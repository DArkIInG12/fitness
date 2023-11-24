import 'package:cached_network_image/cached_network_image.dart';
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

  Map <String,String> ibegginer ={
  'back':'https://phantom-expansion.unidadeditorial.es/6504b0893c1b8924f0c15837975a4226/crop/0x31/2046x1183/resize/1200/f/jpg/assets/multimedia/imagenes/2022/07/15/16578777887898.jpg',
  'cardio':'https://i.blogs.es/63eb96/istock-1212303707/1366_2000.jpeg',
  'chest':'https://entrenamientosfuncionales.com/wp-content/uploads/2022/06/ejercicios-para-aumentar-pecho-hombre-flexiones-straggered.jpg',
  'lower arms':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFOAE0rE_CHZT_7UyfIPlwU8_1vYwcsRparw&usqp=CAU',
  'lower legs':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAa2s7ngLBSYcDtf23TT6XfTM9EIS2v74SRA&usqp=CAU',
  'neck':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmMxKEA_rfJsx_O67XObm-pm787sLTV8BxqA&usqp=CAU',
  'shoulders':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpp6P1lwFaMVCsy9jzM_0fOUSV2uuQfLERUw&usqp=CAU',
  'upper arms':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSb2VTIPGE4Lhu3Ig63wWp4pU7d0g8MN1rjPQ&usqp=CAU',
  'upper legs':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqZeZ9wTZnXchsJ7P9_Kd6hTV3pKVF3wCQcg&usqp=CAU',
  'waist':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPZiqaRvXtYJYZruwtf8cJfWEul0Y2EfI6WLYOvz4cdv9lFiTB4BjtT2u53gFV6sDd6RE&usqp=CAU'
  };
  Map <String,String> iintermediate = {
  'back':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRorS1qaDlIrDlcileWutpk7sBfcypQ1gsqJXY0czoVU53YqZRZQbyxRq1swFpbfEzndHI&usqp=CAU',
  'cardio':'https://i.blogs.es/ce0b48/650_1000_eliptica-correr/650_1200.jpg',
  'chest':'https://images.ecestaticos.com/ceWCtDSWSxyo9OFLTEwOC_-aXe4=/0x0:0x0/1200x900/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2F572%2F679%2F17e%2F57267917e552e4d4474852040d7f390b.jpg',
  'lower arms':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScmwiV-1TxvLeg-xHrrijZQLULQkB8nCoyHA&usqp=CAU',
  'lower legs':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4bvVnQ70FVF93B3NAcGXsmpY4jM_6KSVvQg&usqp=CAU',
  'neck':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUqL0ipkbEgpoYlGGMT9P3TxlZNhM3bC5SuA&usqp=CAU',
  'shoulders':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnkVv4bnp1oVIg5S-gbaYtOTf26pNhwiC-ow&usqp=CAU',
  'upper arms':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzmq5f7mGvSSE9JnY0l7EGgDhX7ZT69E6OKA&usqp=CAU',
  'upper legs':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl-pl_mIBlULQ4oon7RW6F0hXVwPRPkEUCnw&usqp=CAU',
  'waist':'https://i.blogs.es/3573e1/istock_000073977019_medium/1366_2000.jpeg'
  };
  Map <String,String> iadvanced ={
  'back':'https://as01.epimg.net/deporteyvida/imagenes/2020/11/11/portada/1605082637_497921_1605082754_noticia_normal_recorte1.jpg',
  'cardio':'https://weriselatam.com/wp-content/uploads/2021/04/cardio-antes-de-pesas-800x500.jpg',
  'chest':'https://entrenar.me/blog/wp-content/uploads/2018/03/flexiones-para-pectorales.jpg',
  'lower arms':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrOFt4nlH6woVhrWb_csE4v2mYccs63mWH3w&usqp=CAU',
  'lower legs':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLqbpVQjHUnW-sZ_tQHqNEO6sd-ab7Pq-acg&usqp=CAU',
  'neck':'https://www.muscleandfitness.com/wp-content/uploads/2016/04/wide-neck.jpg?quality=86&strip=all',
  'shoulders':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjaYgy9ka5wYivFoWWZ2tHILqZmg14GahKyQ&usqp=CAU',
  'upper arms':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj0ta_eJv_9Ud4s1qkk7-mONzpgG1S7uxivQ&usqp=CAU',
  'upper legs':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqohBH-nQqhzGr0LA_xYI7PSyLuDR6w5Kgwx2voqsB0-TeEyzw8aXpcOSMtYQb8oWrO1o&usqp=CAU',
  'waist':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUf_pXAVIkiOMU7hkGq0XLgAT3YNsB5kV_9g&usqp=CAU'

  };
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
                                var mapI = '';
                                switch (datos[index]['level']){
                                  case 'BEGGINER':
                                    mapI = ibegginer['${datos[index]['bodyPart']}']!;
                                  case 'INTERMEDIATE':
                                    mapI = iintermediate['${datos[index]['bodyPart']}']!;
                                  case 'ADVANCED':
                                    mapI = iadvanced['${datos[index]['bodyPart']}']!;
                                }
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Card(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 5,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 150,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                child: Image(image: CachedNetworkImageProvider(mapI),
                                                  fit: BoxFit.cover,
                                                  ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 5,),
                                        Column(
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
                                        Row(
                                          children: [
                                           Image.asset('assets/images/clock_blue.png', width: 10,),
                                           const SizedBox(width: 5,),
                                           Text('${timeparse(datos[index]['time'])} min',
                                            style:const TextStyle(fontWeight: FontWeight.bold) ,),
                                          const SizedBox(width: 10,),
                                           Image.asset('assets/images/redflame.png', width: 10,),
                                           const SizedBox(width: 5,),
                                           Text('${datos[index]['calories']} cal',
                                            style:const TextStyle(fontWeight: FontWeight.bold) ,),
                                       
                                          ],
                                        )
                                          ],
                                        )

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
