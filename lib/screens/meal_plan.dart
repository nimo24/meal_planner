import 'package:dealy_meal/components/ExportMealPlanDialog.dart';
import 'package:dealy_meal/components/MealOptionsDialog.dart';
import 'package:dealy_meal/components/export.dart';
import 'package:dealy_meal/components/option.dart';
import 'package:dealy_meal/models/ScheduledMeal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/meal_model.dart'; // Import your model
import 'package:intl/intl.dart';
import 'dart:math';

class MealPlanPage extends StatefulWidget {
  @override
  _MealPlanPageState createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  DateTime _selectedDay = DateTime.now();
  late Box<ScheduledMeal> box;
  late Box<Meal> mealsbox;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    box = Hive.box<ScheduledMeal>('scheduledMeals');
    mealsbox = Hive.box<Meal>('favourites');


  }
  void _generateRandomMealPlan() {
  final allMeals = mealsbox.values.toList();

  if (allMeals.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No meals available to generate a plan.')),
    );
    return;
  }

  final mealTypes = ['dessert', 'plat', 'entree'];
  final mealSlots = ['Breakfast', 'Lunch', 'Dinner'];

  setState(() {
    // Clear existing scheduled meals for selected day
    box.values
        .where((sm) => isSameDay(sm.date, _selectedDay))
        .toList()
        .forEach((sm) => box.delete(sm.key));

    // For each meal slot (Breakfast, Lunch, Dinner)
    for (var slot in mealSlots) {
      // For each meal type (dessert, plat, entree)
      for (var type in mealTypes) {
        // Filter meals by type (ignore case)
        final filteredMeals =
            allMeals.where((meal) => meal.type.toLowerCase() == type).toList();

        if (filteredMeals.isNotEmpty) {
          // Pick a random meal of this type
          final randomMeal = filteredMeals[_random.nextInt(filteredMeals.length)];

          // Create ScheduledMeal for this slot and meal type
          final scheduledMeal = ScheduledMeal(
            date: _selectedDay,
            mealType: slot,
            meal: randomMeal,
          );

          box.add(scheduledMeal);
        } else {
          // Optional: fallback or show warning if no meal of this type exists
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('No $type meals available for $slot.')),
          );
        }
      }
    }
  });
}


  List<ScheduledMeal> _getMealsForSelectedDay(String mealType) {
    return box.values
        .where((m) =>
            m.date.year == _selectedDay.year &&
            m.date.month == _selectedDay.month &&
            m.date.day == _selectedDay.day &&
            m.mealType == mealType)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final mealTypes = ['Breakfast', 'Lunch', 'Dinner'];

    return Scaffold(
      appBar: AppBar(
  title: Text(
    "My Meal Plan",
    style: GoogleFonts.nanumMyeongjo( // 🔸 Use Google Font here
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 21, 9, 9), // optional: match your theme
    ),
  ),
  backgroundColor: const Color.fromARGB(19, 255, 255, 255),
  actions: [
   TextButton.icon(
  style: TextButton.styleFrom(
    backgroundColor: Colors.transparent, // transparent background
    side: BorderSide(color: Colors.grey), // border outline
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // optional rounded corners
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  ),
  onPressed: () {
    showDialog(
      context: context,
      builder: (_) => const ExportMealPlanDialog(),
    );
  },
  icon: Image.asset(
    'assets/icons/dfhgj.png', // replace with your actual asset path
    width: 20,
    height: 20,
  ),
  label: const Text(
    "Export",
    style: TextStyle(color: Colors.black), // optional: control label color
  ),
),

  ],
),

      
      
      body: Column(
        children: [
          _buildDateSelector(),
          Expanded(
            child: ListView(
              children: mealTypes.map((type) {
                final meals = _getMealsForSelectedDay(type);
                return _buildMealSection(type, meals);
              }).toList(),
            ),
          ),
        ],
        
      ),

      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromARGB(255, 202, 24, 60), // 🔸 Set your custom background color here

        icon:Image.asset(
    'assets/icons/random.png', // replace with your actual asset path
    width: 20,
    height: 20,
    color: Color.fromARGB(255, 255, 255, 255),
  ),
        label: Text(
    "Export Plan",
    style: GoogleFonts.k2d( // Apply Google Font
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(255, 255, 255, 255), // match border color or pick your own
    ),
  ),
        onPressed: _generateRandomMealPlan,
        tooltip: 'Generate random meal plan for the day',
      ),

    );
    
  }


 Widget _buildDateSelector() {
  // Calculate days in the currently displayed month
  final int year = _selectedDay.year;
  final int month = _selectedDay.month;

  // First day of the month
  final firstDayOfMonth = DateTime(year, month, 1);

  // Number of days in the month
  final daysInMonth = DateTime(year, month + 1, 0).day;

  // List of all days in this month
  final days = List.generate(daysInMonth, (index) => DateTime(year, month, index + 1));

  return Column(
    children: [
      // Month & Year with prev/next buttons
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                setState(() {
                  // Move _selectedDay to previous month, keep day within valid range
                  _selectedDay = DateTime(year, month - 1, 1);
                });
              },
            ),
            Text(
  DateFormat.yMMMM().format(_selectedDay), // e.g. "May 2025"
  style: GoogleFonts.jura(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),

            IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                setState(() {
                  // Move _selectedDay to next month, keep day within valid range
                  _selectedDay = DateTime(year, month + 1, 1);
                });
              },
            ),
          ],
        ),
      ),

      // Horizontal list of days in this month
      SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: days.length,
          itemBuilder: (context, index) {
            final day = days[index];
            final isSelected = isSameDay(day, _selectedDay);

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDay = day;
                });
              },
              child: Container(
                width: 50,
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Color.fromARGB(255, 202, 24, 60) : Color.fromARGB(255, 248, 241, 235),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
  DateFormat.E().format(day),
  style: GoogleFonts.jura(fontSize: 14),
), // Mon, Tue...
                    Text(
  day.day.toString(),
  style: GoogleFonts.jura(fontSize: 16, fontWeight: FontWeight.w600),
)

                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget _buildMealSection(String type, List<ScheduledMeal> meals) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
  type,
  style: GoogleFonts.k2d(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  ),
),

        SizedBox(height: 16), // <-- Add space here between title and cards
        
        ...meals.map((m) => Padding(
  padding: const EdgeInsets.only(bottom: 12),  // Add space below each card
  child: Stack(
  clipBehavior: Clip.none,
  children: [
    Card(
      margin: EdgeInsets.only(left: 30),
      elevation: 0,
      color: Color.fromARGB(255, 248, 241, 235),
      child: Container(
        height: 120,
        padding: EdgeInsets.only(left: 70, right: 12, top: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              m.meal.type.capitalize(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.teal[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              m.meal.title,
              style: GoogleFonts.inter(
    fontSize: 16,
    color: Color.fromARGB(255, 74, 44, 42), // Hex color #E05D00
  ),
            ),
            SizedBox(height: 6),
          Text(
  m.meal.description,
  style: GoogleFonts.inter(
    fontSize: 14,
    color: Color(0xFFE05D00), // Hex color #E05D00
  ),
  maxLines: 3,
  overflow: TextOverflow.ellipsis,
),
          ],
        ),
      ),
    ),

    // Meal image
    Positioned(
      top: 10,
      left: 0,
      bottom: 10,
      child: Container(
        width: 90,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(-7, 10),
              spreadRadius: -10,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            m.meal.photo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),

    // Popup button
    Positioned(
  top: 6,
  right: 6,
  child: IconButton(
      icon: Image.asset(
    'assets/icons/hvdjfmore.png', 
    width: 20,
    height: 20,
  ),
    onPressed: () {
      showDialog(
        context: context,
       builder: (_) => MealOptionsDialog(
  onReplace: () {
    Navigator.pop(context);
    // Add replace logic here
  },
  onModify: () {
    Navigator.pop(context);
    // Add modify logic here
  },
  onDelete: () {
    Navigator.pop(context);
    box.delete(m.key);
    setState(() {});
  },
),

      );
    },
  ),
),

  ],
),

))
,
        if (meals.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child:Center(
            child: Text(
    "You haven't added any meals here",
    style: GoogleFonts.juliusSansOne(
      fontSize: 12,
      color: Color.fromARGB(255, 111, 96, 96), // optional color
    ),
  ),)
          )
      ],
    ),
  );
}

}

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
