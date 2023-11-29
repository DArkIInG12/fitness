import 'dart:math';

import 'package:fitness/firebase/exercises.dart';
import 'package:fitness/global_values.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/models/exercise_model.dart';
import 'package:fitness/network/apiE.dart';
import 'package:fitness/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

List bodyParts = [];
List<ExcerciceModel>? excercices;
ExercisesFirebase? bd;
ApiE? apiE;
Map<DateTime, List<dynamic>> datesmap = {};

List<dynamic> getDates(DateTime day) {
  print(datesmap);
  return datesmap[day] ?? [];
}

List imagesBodyPartsB = [
  'https://phantom-expansion.unidadeditorial.es/6504b0893c1b8924f0c15837975a4226/crop/0x31/2046x1183/resize/1200/f/jpg/assets/multimedia/imagenes/2022/07/15/16578777887898.jpg',
  'https://i.blogs.es/63eb96/istock-1212303707/1366_2000.jpeg',
  'https://entrenamientosfuncionales.com/wp-content/uploads/2022/06/ejercicios-para-aumentar-pecho-hombre-flexiones-straggered.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFOAE0rE_CHZT_7UyfIPlwU8_1vYwcsRparw&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAa2s7ngLBSYcDtf23TT6XfTM9EIS2v74SRA&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmMxKEA_rfJsx_O67XObm-pm787sLTV8BxqA&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpp6P1lwFaMVCsy9jzM_0fOUSV2uuQfLERUw&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSb2VTIPGE4Lhu3Ig63wWp4pU7d0g8MN1rjPQ&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqZeZ9wTZnXchsJ7P9_Kd6hTV3pKVF3wCQcg&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPZiqaRvXtYJYZruwtf8cJfWEul0Y2EfI6WLYOvz4cdv9lFiTB4BjtT2u53gFV6sDd6RE&usqp=CAU'
];
List imagesBodyPartsI = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRorS1qaDlIrDlcileWutpk7sBfcypQ1gsqJXY0czoVU53YqZRZQbyxRq1swFpbfEzndHI&usqp=CAU',
  'https://i.blogs.es/ce0b48/650_1000_eliptica-correr/650_1200.jpg',
  'https://images.ecestaticos.com/ceWCtDSWSxyo9OFLTEwOC_-aXe4=/0x0:0x0/1200x900/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2F572%2F679%2F17e%2F57267917e552e4d4474852040d7f390b.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScmwiV-1TxvLeg-xHrrijZQLULQkB8nCoyHA&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4bvVnQ70FVF93B3NAcGXsmpY4jM_6KSVvQg&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUqL0ipkbEgpoYlGGMT9P3TxlZNhM3bC5SuA&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnkVv4bnp1oVIg5S-gbaYtOTf26pNhwiC-ow&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzmq5f7mGvSSE9JnY0l7EGgDhX7ZT69E6OKA&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl-pl_mIBlULQ4oon7RW6F0hXVwPRPkEUCnw&usqp=CAU',
  'https://i.blogs.es/3573e1/istock_000073977019_medium/1366_2000.jpeg'
];
List imagesBodyPartsA = [
  'https://as01.epimg.net/deporteyvida/imagenes/2020/11/11/portada/1605082637_497921_1605082754_noticia_normal_recorte1.jpg',
  'https://weriselatam.com/wp-content/uploads/2021/04/cardio-antes-de-pesas-800x500.jpg',
  'https://entrenar.me/blog/wp-content/uploads/2018/03/flexiones-para-pectorales.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrOFt4nlH6woVhrWb_csE4v2mYccs63mWH3w&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLqbpVQjHUnW-sZ_tQHqNEO6sd-ab7Pq-acg&usqp=CAU',
  'https://www.muscleandfitness.com/wp-content/uploads/2016/04/wide-neck.jpg?quality=86&strip=all',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjaYgy9ka5wYivFoWWZ2tHILqZmg14GahKyQ&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj0ta_eJv_9Ud4s1qkk7-mONzpgG1S7uxivQ&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqohBH-nQqhzGr0LA_xYI7PSyLuDR6w5Kgwx2voqsB0-TeEyzw8aXpcOSMtYQb8oWrO1o&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUf_pXAVIkiOMU7hkGq0XLgAT3YNsB5kV_9g&usqp=CAU'
];
Random number = Random();
DateTime today = DateTime.now();

List<int> getCurrentWeek() {
  DateTime now = DateTime.now();
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  //DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

  return List.generate(
      7, (index) => startOfWeek.add(Duration(days: index)).day);
}

Widget trainingWidget(context) {
  var provider = Provider.of<ProviderModel>(context);
  List days = getCurrentWeek();
  bd = ExercisesFirebase();
  apiE = ApiE();

  return Column(
    children: [
      FutureBuilder(
          future: bd!
              .getDocsEquals('ejercicios', 'user', provider.currentUserEmail),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> datos = snapshot.data!;
              double cal_total = 0;
              double time = 0;
              int cant = datos.length;
              Map<DateTime, List> formateddates = {};
              for (int i = 0; i < datos.length; i++) {
                cal_total += double.parse(datos[i]['calories']);
                time += datos[i]['time'];
                final datee = DateTime.parse(datos[i]['date']
                        .toString()
                        .replaceRange(10, null, ' 00:00:00.000Z'))
                    .toUtc();
                formateddates.update(
                  datee,
                  (value) {
                    value.add(datos[i]);
                    return value;
                  },
                  ifAbsent: () => [datos[i]],
                );
              }
              datesmap = formateddates;

              Color? color;
              if (GlobalValues.darkTheme == ValueNotifier<bool>(false)) {
                color = const Color.fromRGBO(243, 243, 243, 0.937);
              } else {
                 color =const Color.fromRGBO(243, 243, 243, 0.237);
              }

              return FutureBuilder(
                  future: apiE!.getBodyPartList(),
                  builder: (cintext, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      bodyParts = snapshot.data;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cant.toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("WORKOUTS")
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cal_total.toStringAsFixed(1),
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("CAL")
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (time / 60).truncate().toString(),
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("MINUTE")
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/calendar');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: color),
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 18, 20, 18),
                              width: double.infinity,
                              //color: Colors.grey,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color),
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 18, 20, 18),
                                width: double.infinity,
                                child: TableCalendar(
                                  eventLoader: getDates,
                                  headerVisible: false,
                                  firstDay: DateTime.utc(2023, 01, 01),
                                  lastDay: DateTime.utc(2030, 12, 31),
                                  focusedDay: DateTime.now(),
                                  availableCalendarFormats: const {
                                    CalendarFormat.week: 'Week',
                                  },
                                  calendarFormat: CalendarFormat.week,
                                  startingDayOfWeek: StartingDayOfWeek.monday,
                                  calendarStyle: const CalendarStyle(
                                    todayDecoration: BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ),
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
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                for (var i = 0; i < bodyParts.length; i++)
                                  GestureDetector(
                                    child: Container(
                                      width: double.infinity,
                                      height: 170,
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              opacity: 1.0,
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  imagesBodyPartsB[i]))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/thunderB.png'),
                                                Image.asset(
                                                    'assets/images/thunderW.png'),
                                                Image.asset(
                                                    'assets/images/thunderW.png')
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              bodyParts[i]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 26),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      apiE!
                                          .getExcercices(bodyParts[i])
                                          .then((value) {
                                        excercices = value;
                                      }).whenComplete(() {
                                        Navigator.pushNamed(
                                            context, '/excercices',
                                            arguments: {
                                              'level': 'BEGGINER',
                                              'bodyPart': bodyParts[i],
                                              'list': excercices,
                                              'img': imagesBodyPartsB[i]
                                            });
                                      });
                                    },
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "INTERMEDIATE",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                for (var i = 0; i < bodyParts.length; i++)
                                  GestureDetector(
                                    child: Container(
                                      width: double.infinity,
                                      height: 170,
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              opacity: 1.0,
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  imagesBodyPartsI[i]))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/thunderB.png'),
                                                Image.asset(
                                                    'assets/images/thunderB.png'),
                                                Image.asset(
                                                    'assets/images/thunderW.png')
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              bodyParts[i]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 26),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      apiE!
                                          .getExcercices(bodyParts[i])
                                          .then((value) {
                                        excercices = value;
                                      }).whenComplete(() {
                                        Navigator.pushNamed(
                                            context, '/excercices',
                                            arguments: {
                                              'level': 'INTERMEDIATE',
                                              'bodyPart': bodyParts[i],
                                              'list': excercices,
                                              'img': imagesBodyPartsI[i]
                                            });
                                      });
                                    },
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "ADVANCED",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                for (var i = 0; i < bodyParts.length; i++)
                                  GestureDetector(
                                    child: Container(
                                      width: double.infinity,
                                      height: 170,
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              opacity: 1.0,
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  imagesBodyPartsA[i]))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/thunderB.png'),
                                                Image.asset(
                                                    'assets/images/thunderB.png'),
                                                Image.asset(
                                                    'assets/images/thunderB.png')
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              bodyParts[i]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 26),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      apiE!
                                          .getExcercices(bodyParts[i])
                                          .then((value) {
                                        excercices = value;
                                      }).whenComplete(() {
                                        Navigator.pushNamed(
                                            context, '/excercices',
                                            arguments: {
                                              'level': 'ADVANCED',
                                              'bodyPart': bodyParts[i],
                                              'list': excercices,
                                              'img': imagesBodyPartsA[i]
                                            });
                                      });
                                    },
                                  ),
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    ],
  );
}
