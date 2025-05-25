import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import '../models/meal_model.dart';

class MealCard extends StatefulWidget {
  final Meal meal;

  const MealCard({Key? key, required this.meal}) : super(key: key);

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  late bool isFavourite;
  late Box<Meal> favouritesBox;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.meal.isFavourite;
    favouritesBox = Hive.box<Meal>('favourites');
  }

  void toggleFavourite() {
  setState(() {
    isFavourite = !isFavourite;          // Toggle true <-> false
    widget.meal.isFavourite = isFavourite; // Update the meal model too
  });

  // Save or remove from Hive box
  if (isFavourite) {
    favouritesBox.put(widget.meal.id, widget.meal);
  } else {
    favouritesBox.delete(widget.meal.id);
  }
}


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Card body
          Container(
            margin: const EdgeInsets.only(top: 60),
            padding: const EdgeInsets.fromLTRB(12, 60, 12, 12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 228, 229, 223),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 4),
                  blurRadius: 3,
                )
              ],
            ),
            child: Column(
              children: [
                const Spacer(),
                Text(
                  widget.meal.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.elMessiri(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.meal.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jura(
                    fontSize: 12,
                    color: Color.fromARGB(255, 126, 109, 109),
                  ),
                ),
                const SizedBox(height: 0),
                IconButton(
  iconSize: 24,
  icon: Image.asset(
    isFavourite
        ? 'assets/icons/star.png'  // show filled star if true
        : 'assets/icons/starr.png', // outline star if false
    color: isFavourite
        ? const Color.fromARGB(255, 187, 37, 42)  // red color if favourite
        : const Color.fromARGB(255, 202, 191, 152), // lighter if not
    height: 24,
    width: 24,
  ),
  onPressed: toggleFavourite,
),

              ],
            ),
          ),

          // Floating image
          Positioned(
            top: 20,
            left: 24,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
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
                  widget.meal.photo,
                  height: 135,
                  width: 135,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
