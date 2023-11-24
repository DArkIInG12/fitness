import 'package:fitness/firebase/exercises.dart';
import 'package:fitness/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  ExercisesFirebase? bd;
  Map<DateTime, List<dynamic>> datesmap = {};
  List<dynamic> selectedEvents = [];
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();

  List<dynamic> getDates(DateTime day) {
    print(datesmap);
    return datesmap[day] ?? [];
  }

  @override
  void initState() {
    super.initState();
    bd = ExercisesFirebase();
    selectedDay = focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderModel>(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  expandedHeight: 150,
                  floating: false,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      'assets/images/registro.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(40.0),
                    child: Container(
                      alignment: Alignment.center,
                      color: const Color.fromRGBO(0, 0, 255, 1),
                      child: const Text(
                        'Record',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: FutureBuilder(
                future: bd!.getDocsEquals(
                    'ejercicios', 'user', provider.currentUserEmail),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> datos = snapshot.data!;
                    Map<DateTime, List> formateddates = {};
                    for (int i = 0; i < datos.length; i++) {
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
                        const SizedBox(
                          height: 30,
                        ),
                        TableCalendar(
                          eventLoader: getDates,
                          headerVisible: false,
                          firstDay: DateTime.utc(2023, 01, 01),
                          lastDay: DateTime.utc(2030, 12, 31),
                          focusedDay: DateTime.now(),
                          availableCalendarFormats: const {
                            CalendarFormat.month: 'Month',
                          },
                          calendarFormat: CalendarFormat.month,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          calendarStyle: const CalendarStyle(
                            todayDecoration: BoxDecoration(
                                color: Colors.orange, shape: BoxShape.circle),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: datos.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          datos[index]['date'],
                                          style: const TextStyle(
                                              fontSize: 12),
                                        ),
                                        Text(
                                          datos[index]['bodyPart'].toString().toUpperCase(),
                                          style:  const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          datos[index]['level'].toString().toUpperCase(),
                                          style:  const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }
}
