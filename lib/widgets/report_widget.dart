import 'package:fitness/firebase/exercises.dart';
import 'package:fitness/provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';

Widget reportWidget(ProviderModel prov) {
  Map<DateTime, List<dynamic>> datesmap = {};

  List<dynamic> getDates(DateTime day) {
    print(datesmap);
    return datesmap[day] ?? [];
  }

  ExercisesFirebase bd = ExercisesFirebase();
  TooltipBehavior tooltipBehavior = TooltipBehavior();
  return FutureBuilder(
      future: bd.getDocsEquals('ejercicios', 'user', prov.currentUserEmail),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> datos = snapshot.data!;
          double cal_total = 0;
          double time = 0;
          int cant = datos.length;
          Map<String, int> contBodyPart = {};
          Map<DateTime, List> formateddates = {};
          List<String> dates = [];
          for (int i = 0; i < datos.length; i++) {
            cal_total += double.parse(datos[i]['calories']);
            time += datos[i]['time'];
            dates.add(datos[i]['date']);
            String bodyPart = datos[i]['bodyPart'];
            if (contBodyPart.containsKey(bodyPart)) {
              contBodyPart[bodyPart] = contBodyPart[bodyPart]! + 1;
            } else {
              contBodyPart[bodyPart] = 1;
            }
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

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(243, 243, 243, 0.937)),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                width: double.infinity,
                //color: Colors.grey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/images/medal.png', width: 30),
                        const SizedBox(height: 10),
                        Text(
                          datos.length.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        const Text('Exercises')
                      ],
                    ),
                    Column(
                      //#1242E0
                      children: [
                        Image.asset('assets/images/flame.png', width: 30),
                        const SizedBox(height: 10),
                        Text(
                          cal_total.toStringAsFixed(1),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        const Text('Calories')
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('assets/images/clock_blue.png', width: 30),
                        const SizedBox(height: 10),
                        Text(
                          (time / 60).truncate().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        const Text('Minute')
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Record',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/calendar');
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(243, 243, 243, 0.937)),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
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
                          color: Colors.orange, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(243, 243, 243, 0.937)),
                width: double.infinity,
                child: SfCircularChart(
                  title: ChartTitle(
                      text: 'Body Part Exercises',
                      textStyle: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  legend: const Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: tooltipBehavior,
                  series: <CircularSeries>[
                    DoughnutSeries<GDCData, String>(
                        dataSource: getCircularData(contBodyPart),
                        xValueMapper: (GDCData data, _) =>
                            data.field.toUpperCase(),
                        yValueMapper: (GDCData data, _) => data.value,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ))
                  ],
                ),
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

List<GDCData> getCircularData(Map<String, int> map) {
  List<GDCData> data = [];
  Iterable<String> keys = map.keys;
  for (final key in keys) {
    data.add(GDCData(key, map[key]!));
  }

  return data;
}

class GDCData {
  GDCData(this.field, this.value);
  final String field;
  final int value;
}
