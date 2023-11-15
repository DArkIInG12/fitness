import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/models/exercise_model.dart';
import 'package:fitness/network/apiE.dart';
import 'package:flutter/material.dart';

List bodyParts = [];
List<ExcerciceModel>? excercices;
ApiE? apiE;

List imagesBodyParts = [
  'https://img.mensxp.com/media/content/2022/Nov/shutterstock_673719400_637dffdb71b11.jpeg',
  'https://media-cldnry.s-nbcnews.com/image/upload/rockcms/2021-12/211208-working-out-stock-mn-1310-55e1c7.jpg',
  'https://www.mensjournal.com/.image/t_share/MTk2MTM2NDIwMTA3NTYwNDUz/shutterstock_570689305.jpg',
  'https://www.eatthis.com/wp-content/uploads/sites/4/2022/12/fitness-woman-arm-workout-machine.jpg?quality=82&strip=1',
  'https://www.muscleandfitness.com/wp-content/uploads/2000/09/Man-And-Woman-Showing-Muscular-Legs.jpg?quality=86&strip=all',
  'https://www.dmoose.com/cdn/shop/articles/1_68d5f8c2-0791-4a41-86db-e7f224b142ea.jpg?v=1649931793',
  'https://workout-temple.com/wp-content/uploads/2022/10/pike-push-ups-usmall.jpg',
  'https://hips.hearstapps.com/hmg-prod/images/young-man-doing-dips-in-the-local-park-royalty-free-image-1691581525.jpg?crop=1xw:0.84415xh;center,top&resize=1200:*',
  'https://staticg.sportskeeda.com/editor/2023/07/498f6-16896051074260-1920.jpg?w=840',
  'https://media-cldnry.s-nbcnews.com/image/upload/t_social_share_1200x630_center,f_auto,q_auto:best/rockcms/2022-09/15-waist-slimming-exercises-zz-220926-021483.jpg',
];
Random number = Random();

Widget trainingWidget(context) {
  List days = [1, 2, 3, 4, 5, 6, 7];
  apiE = ApiE();
  return FutureBuilder(
      future: apiE!.getBodyPartList(),
      builder: (cintext, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          bodyParts = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "21",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("WORKOUTS")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "4512",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("KCAL")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "195",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("MINUTES")
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(243, 243, 243, 0.937)),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                width: double.infinity,
                //color: Colors.grey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "WEEK GOAL",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        const Text(
                          "0/5",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: days.map((day) {
                          return Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              width: 30,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color.fromRGBO(
                                      219, 219, 219, 0.929)),
                              child: Center(
                                child: Text(
                                  day.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: day == 4
                                          ? Colors.blue
                                          : Colors.black),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "BEGGINER",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (var i = 0; i < bodyParts.length; i++)
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 170,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  opacity: 1.0,
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      imagesBodyParts[i]))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${bodyParts[i]} BEGGINER"),
                              Text("${number.nextInt(16)} EXERCISES")
                            ],
                          ),
                        ),
                        onTap: () {
                          apiE!.getExcercices(bodyParts[i]).then((value) {
                            excercices = value;
                          }).whenComplete(() {
                            Navigator.pushNamed(context, '/excercices',
                                arguments: {
                                  'bodyPart': bodyParts[i],
                                  'list': excercices
                                });
                          });
                        },
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "INTERMEDIATE",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (var i = 0; i < bodyParts.length; i++)
                      Container(
                        width: double.infinity,
                        height: 70,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromRGBO(219, 219, 219, 0.929)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${bodyParts[i]} INTERMEDIATE"),
                            Text("${number.nextInt(16)} EXERCISES")
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "ADVANCED",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (var i = 0; i < bodyParts.length; i++)
                      Container(
                        width: double.infinity,
                        height: 70,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromRGBO(219, 219, 219, 0.929)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${bodyParts[i]} ADVANCED"),
                            Text("${number.nextInt(16)} EXERCISES")
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          );
        } else {
          return const Text('No c logro :(');
        }
      });
}
