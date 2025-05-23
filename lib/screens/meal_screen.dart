
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override

  List<DateTime?>? dates;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF998b8f),
      body: SafeArea(
        top: true,
        bottom: true,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 40,
                    right: 20,
                    left: 30
                  ),
                  width: MediaQuery.of(context).size.width * 0.97,
                  height: MediaQuery.of(context).size.height - 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFf0ecec),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60)
                    )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.97 - 30 - 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                child: Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                onTap: (){

                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Blueberry Almond Delight Bagel',
                                style: TextStyle(
                                  fontSize: 28
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 100,),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book'),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: () async{
                            dates = await showCalendarDatePicker2Dialog(
                              context: context,
                              config: CalendarDatePicker2WithActionButtonsConfig(
                              ),
                              dialogSize: const Size(325, 400),
                              borderRadius: BorderRadius.circular(15),
                              value: dates ?? []
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                              ),
                              SizedBox(width: 5,),
                              Text('add this meal to your meal plan')
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'add a text here describing your experience with this dish...',
                            hintStyle: TextStyle(
                              fontSize: 12
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(10)
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 30,),
                        Text(
                          'Posted comments',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?img=3',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'tasty and loved the almond crunch!',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: MediaQuery.of(context).size.width - 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/meal.png", // Replace with your image
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}