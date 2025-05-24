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

  @override
  void initState() {
    super.initState();
    isFavourite = widget.meal.isFavourite;
  }

  void toggleFavourite() async {
    final box = Hive.box('favourites');
    setState(() {
      isFavourite = !isFavourite;
      widget.meal.isFavourite = isFavourite;
    });

    if (isFavourite) {
      box.put(widget.meal.id, widget.meal);
    } else {
      box.delete(widget.meal.id);
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
    const Spacer(), // pushes content downward
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
  icon: Icon(
    isFavourite ? Icons.star_rounded : Icons.star_border_rounded,
    color: isFavourite ? Color.fromARGB(255, 187, 37, 42) : const Color.fromARGB(255, 202, 191, 152),
    size: 20,
  ),
  onPressed: toggleFavourite,
),

  ],
),

          ),

          // Floating image (slightly lower)
          Positioned(
            top: 20, // Lowered from 0 to 20
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
