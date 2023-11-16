import 'dart:math';

import 'package:fitness/global_values.dart';
import 'package:flutter/material.dart';

List bodyParts = ["ABS", "CHEST", "ARM", "LEG", "SHOULDER & BACK"];
Random number = Random();
DateTime today = DateTime.now();

List<int> getCurrentWeek() {
  DateTime now = DateTime.now();
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  //DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

  return List.generate(
      7, (index) => startOfWeek.add(Duration(days: index)).day);
}

Widget trainingWidget() {
  List days = getCurrentWeek();
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "WEEK GOAL",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
                          color: const Color.fromRGBO(219, 219, 219, 0.929)),
                      child: Center(
                        child: Text(
                          day.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: day == today.day
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    Text("${bodyParts[i]} BEGGINER"),
                    Text("${number.nextInt(16)} EXERCISES")
                  ],
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "INTERMEDIATE",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
}
