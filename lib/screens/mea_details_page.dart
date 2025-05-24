import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/meal_model.dart';
import '../models/comment_model.dart'; // import the comment model

class DetailPage extends StatefulWidget {
  final Meal meal;

  const DetailPage({Key? key, required this.meal}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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


  @override
  Widget build(BuildContext context) {
    final comments = commentBox.values
    .where((c) => c.mealId == widget.meal.id)
    .toList();


    return Scaffold(
      backgroundColor: const Color(0xFFD3C7C3),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(top: 120, left: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F1F0),
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
                        Text(widget.meal.title,
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Text(widget.meal.detailedDescription,
                            style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.black87)),
                        const SizedBox(height: 24),
                        Text("Type: ${widget.meal.type}",
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                          'assets/icons/sdlfjlsdk.png',
                         width: 30,
                            height: 30,
),

                          label: const Text("Add this meal to your meal plan?"),
                           style: ButtonStyle(
    overlayColor: MaterialStateProperty.all(Colors.transparent), // disables hover effect
    // Optionally, also remove elevation or borders if needed:
    elevation: MaterialStateProperty.all(0), 
  ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "Leave feedback here",
                            
                              contentPadding: const EdgeInsets.all(12),
    border: InputBorder.none, // <- No border
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
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
                              child:Container(
                                 padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey[300], // Light grey background
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
                              )
                            )),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 0,
                    child: IconButton(
                      icon:  Image.asset(
                          'assets/icons/starr.png',
                         width: 30,
                            height: 30,
),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: -100,
            child:Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(-15, 10),
                    spreadRadius: -10,
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
