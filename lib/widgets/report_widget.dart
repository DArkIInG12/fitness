import 'package:fitness/firebase/exercises.dart';
import 'package:fitness/global_values.dart';
import 'package:fitness/provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math' as math;

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
          Map<String, double> contBodyPart = {};
          Map<String, double> plusTime = {};
          Map<DateTime, List> formateddates = {};
          List<String> dates = [];
          Map<String, Color> colors = {};
          for (int i = 0; i < datos.length; i++) {
            cal_total += double.parse(datos[i]['calories']);
            time += datos[i]['time'];
            dates.add(datos[i]['date']);
            String bodyPart = datos[i]['bodyPart'];
            if (contBodyPart.containsKey(bodyPart)) {
              contBodyPart[bodyPart] =
                  contBodyPart[bodyPart]! + 1;
            } else {
              contBodyPart[bodyPart] = 1;
              colors[bodyPart] =
                  (Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0));
            }

            if (plusTime.containsKey(bodyPart)) {
              plusTime[bodyPart] = plusTime[bodyPart]! +
                  double.parse(datos[i]['time'].toString());
            } else {
              plusTime[bodyPart] = double.parse(datos[i]['time'].toString());
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
          Color? color;
          if (GlobalValues.darkTheme == ValueNotifier<bool>(false)) {
            color = const Color.fromRGBO(243, 243, 243, 0.937);
          } else {
            color = const Color.fromRGBO(243, 243, 243, 0.137);
          }

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: color),
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
                      borderRadius: BorderRadius.circular(10), color: color),
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
                    borderRadius: BorderRadius.circular(10), color: color),
                width: double.infinity,
                child: SfCircularChart(
                  annotations: [
                    CircularChartAnnotation(
                        height: '100%',
                        width: '100%',
                        widget: PhysicalModel(
                          color: color,
                          shape: BoxShape.circle,
                          elevation: 10,
                          child: Container(),
                        )),
                    CircularChartAnnotation(
                        widget: Center(
                          child: Text(datos.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20),),
                        ))
                  ],
                  title: ChartTitle(
                      text: 'Body Part Exercises Number',
                      textStyle: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  legend: const Legend(
                      isVisible: true,
                      title: LegendTitle(
                          text: 'BODY PARTS',
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: tooltipBehavior,
                  series: <CircularSeries>[
                    DoughnutSeries<GDCData, String>(
                        dataSource: getCircularData(contBodyPart, colors),
                        xValueMapper: (GDCData data, _) =>
                            data.field.toUpperCase(),
                        yValueMapper: (GDCData data, _) => data.value,
                        pointColorMapper: (GDCData data, _) => data.color,
                        dataLabelMapper: (GDCData data, _) =>
                            data.value.toStringAsFixed(0),
                        dataLabelSettings: const DataLabelSettings(
                            isVisible: true, useSeriesColor: true))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: color),
                width: double.infinity,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(arrangeByIndex: true,
                    labelsExtent: 20),
                  primaryYAxis:
                      NumericAxis(minimum: 0, maximum: 30, interval: 5, title:AxisTitle(text: 'Minutes')),
                  title: ChartTitle(
                      text: 'Body Part Exercises Time Worked',
                      textStyle: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  legend: const Legend(
                      isVisible: false,
                      overflowMode: LegendItemOverflowMode.none),
                  tooltipBehavior: tooltipBehavior,
                  series: <ChartSeries>[
                    ColumnSeries<GDBData, String>(
                        dataSource: getBarData(plusTime, colors),
                        xValueMapper: (GDBData data, _) =>
                            data.field.toUpperCase(),
                        yValueMapper: (GDBData data, _) => data.value / 60,
                        pointColorMapper: (GDBData data, _) => data.color,
                        dataLabelMapper: (GDBData data, _) =>
                            '${timeparse(data.value.toInt())}',
                        dataLabelSettings: const DataLabelSettings(
                            isVisible: true, useSeriesColor: true,offset: Offset.zero,borderWidth: 1 
                            ))
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

List<GDCData> getCircularData(
    Map<String, double> map, Map<String, Color> mapColors) {
  List<GDCData> data = [];
  Iterable<String> keys = map.keys;
  for (final key in keys) {
    data.add(GDCData(key, map[key]!, mapColors[key]!));
  }

  return data;
}

String timeparse(int seconds) {
  if (seconds <= 9) {
    return '00:0$seconds';
  } else if (seconds > 9 && seconds <= 60) {
    return '00:$seconds';
  } else {
    int residuo = seconds % 60;
    int minutes = (seconds / 60).truncate();
    if (residuo > 9 && minutes > 9) {
      return '$minutes:$residuo';
    } else if (residuo <= 9 && minutes > 9) {
      return '$minutes:0$residuo';
    } else if (residuo > 9 && minutes < 9) {
      return '0$minutes:$residuo';
    } else {
      return '0$minutes:0$residuo';
    }
  }
}

List<GDBData> getBarData(
    Map<String, double> map, Map<String, Color> mapColors) {
  List<GDBData> data = [];
  Iterable<String> keys = map.keys;
  for (final key in keys) {
    data.add(GDBData(key, map[key]!, mapColors[key]!));
  }

  return data;
}

class GDCData {
  GDCData(this.field, this.value, this.color);
  final String field;
  final double value;
  final Color color;
}

class GDBData {
  GDBData(this.field, this.value, this.color);
  final String field;
  final double value;
  final Color color;
}
