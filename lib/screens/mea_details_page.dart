import 'package:dealy_meal/components/pop_up_detail.dart';
import 'package:dealy_meal/models/ScheduledMeal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/meal_model.dart';
import '../models/comment_model.dart'; // import the comment model
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  final Meal meal;

  const DetailPage({Key? key, required this.meal}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();

  
}

class _DetailPageState extends State<DetailPage> {
  int _selectedRating = 0;

  bool _isHovering = false;
  OverlayEntry? _overlayEntry;

  final TextEditingController _controller = TextEditingController();
  late Box<Comment> commentBox;

  @override
  void initState() {
    super.initState();
    commentBox = Hive.box<Comment>('commentsBox');
  }

  void _addComment() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final comment = Comment(text, widget.meal.id); // save with meal ID
      commentBox.add(comment);
      _controller.clear();
      setState(() {}); // refresh UI
    }
  }

  void _showRatingPopup(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 140,
        left: 40,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Image.asset(
                          'assets/icons/starr.png',
                          width: 30,
                          height: 30,
                        ),
                  onPressed: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                    _overlayEntry?.remove();
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final comments =
        commentBox.values.where((c) => c.mealId == widget.meal.id).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFD3C7C3),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(top: 120, left: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 240, 236, 236),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
              ),
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 180, bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.meal.title,
                          style: GoogleFonts.elMessiri(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.meal.detailedDescription,
                          style: GoogleFonts.jura(
                            fontSize: 16,
                            height: 1.5,
                            color: Color.fromARGB(255, 124, 113, 113),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Type: ${widget.meal.type}",
                          style: GoogleFonts.jura(
                            color: Color.fromARGB(255, 42, 12, 12),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                         onPressed: () {
  showDialog(
    context: context,
    builder: (context) => CalendarPopup(
      onValidate: (date, mealType) async {
        final box = await Hive.openBox<ScheduledMeal>('scheduledMeals');
        box.add(ScheduledMeal(
          date: date,
          mealType: mealType,
          meal: widget.meal,
        ));
        Navigator.of(context).pop(); // Optional: close DetailPage if you want
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Meal added to your plan!')),
        );
      },
    ),
  );
},

                          icon: Image.asset(
                            'assets/icons/sdlfjlsdk.png',
                            width: 30,
                            height: 30,
                          ),
                          label: Text(
                            "Add this meal to your meal plan?",
                            style: GoogleFonts.jura(
                              fontSize: 16,
                              color: Colors.black, // Change color as needed
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "Leave feedback here",
                            hintStyle: GoogleFonts.jura(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            contentPadding: const EdgeInsets.all(12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Image.asset(
                                'assets/icons/hjghj.png',
                                width: 30,
                                height: 30,
                              ),
                              onPressed: _addComment,
                            ),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        const Text("Posted comments"),
                        const SizedBox(height: 8),
                        ...comments.map((c) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    Colors.grey[300], // Light grey background
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.black),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(c.text)),
                                ],
                              ),
                            ))),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 0,
                    child: MouseRegion(
                      onEnter: (_) {
                        _showRatingPopup(context);
                        setState(() {
                          _isHovering = true;
                        });
                      },
                      onExit: (_) {
                        _overlayEntry?.remove();
                        setState(() {
                          _isHovering = false;
                        });
                      },
                      child: IconButton(
                        icon: Image.asset(
                          'assets/icons/starr.png',
                          width: 30,
                          height: 30,
                        ),
                        
                        onPressed: () {
                          _showRatingPopup(context);
                        },
                      ),
                      
                    ),
                  ),
                  if (_selectedRating > 0)
  Positioned(
    top: 60,  // adjust the position below the star icon
    left: 0,  // align with the star icon's left position
    child: Row(
      children: List.generate(
        _selectedRating,
         (index) => Padding(
          padding: const EdgeInsets.only(right: 4), // spacing between icons
          child: Image.asset(
            'assets/icons/star.png',
            width: 20,
            height: 20,
            color: Color.fromARGB(255, 202, 24, 60), // Optional: tint the icon yellow like a star
          ),
        ),
      ),
    ),
  ),

                ],
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: -100,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(35, 0, 0, 0),
                    blurRadius: 8,
                    offset: Offset(-15, 10),
                    spreadRadius: -30,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  widget.meal.photo,
                  width: 350,
                  height: 350,
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
