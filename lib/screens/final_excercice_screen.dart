import 'package:fitness/firebase/exercises.dart';
import 'package:fitness/global_values.dart';
import 'package:fitness/network/apiE.dart';
import 'package:fitness/provider.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:fitness/widgets/report_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FinalExcerciceScreen extends StatefulWidget {
  const FinalExcerciceScreen({super.key});

  @override
  State<FinalExcerciceScreen> createState() => _FinalExcerciceScreenState();
}

class _FinalExcerciceScreenState extends State<FinalExcerciceScreen> {
  Map<String, dynamic>? arguments;
  ApiE? apiE;
  ScrollController? _scrollController;
  Color? color, container;
  List<dynamic>? dataG;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (GlobalValues.darkTheme == ValueNotifier<bool>(false)) {
      color = Colors.black;
      container = const Color.fromRGBO(243, 243, 243, 0.937);
    } else {
      color = Colors.white;
      container = const Color.fromRGBO(243, 243, 243, 0.237);
    }
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TooltipBehavior tooltipBehavior = TooltipBehavior();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ExercisesFirebase bd = ExercisesFirebase();
    var provider = Provider.of<ProviderModel>(context);
    apiE = ApiE();
    arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    dataG = arguments!['timesE'];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor:
              GlobalValues.darkTheme.value ? Colors.black : Colors.white,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  expandedHeight: 180,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Opacity(
                      opacity: 1.0,
                      child: Image.asset(
                        'assets/images/finejercicio.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(40.0),
                    child: Container(
                      alignment: Alignment.center,
                      color: const Color.fromRGBO(0, 0, 255, 1),
                      child: Text(
                        '${arguments!['level'].toString().toUpperCase()} ${arguments!['bodyPart'].toString().toUpperCase()}',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Congragulations !!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Container(
                        color: container,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Exercises',
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/pesas.png',
                                      width: 50,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      arguments!['num'].toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Calories',
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/calories.png',
                                      width: 50,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      arguments!['cal'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Time',
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/clock.png',
                                      width: 50,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      arguments!['time'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: container),
                        width: double.infinity,
                        child: SfCircularChart(
                          title: ChartTitle(
                              text: 'Body Part Exercises Time Worked (minutes)',
                              textStyle: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                      legend: const Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
                      title: LegendTitle(
                          text: 'Exercises',

                          textStyle: TextStyle(fontWeight: FontWeight.bold))),
                          tooltipBehavior: tooltipBehavior,
                          series: <CircularSeries>[
                            PieSeries<GDLData, String>(
                                dataSource: getLData(dataG!),
                                xValueMapper: (GDLData data, _) =>
                                    data.field.toUpperCase(),
                                yValueMapper: (GDLData data, _) => data.value,
                                pointColorMapper: (GDLData data,_) => data.color,
                                dataLabelMapper: (GDLData data,_) => timeparse(data.value.toInt()) ,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    useSeriesColor: true,
                                    labelPosition: ChartDataLabelPosition.inside,
                                    borderWidth: 1))
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ButtonWidget(
                                text: 'Next',
                                onClick: () {
                                  Navigator.pushNamed(context, '/dashboard');
                                },
                                backgroundColor:
                                    const Color.fromRGBO(0, 0, 255, 1),
                                icono: const Icon(Icons.skip_next)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

List<GDLData> getLData(List<dynamic> list) {
  List<GDLData> data = [];
  for (var i = 0; i < list.length; i++) {
    data.add(GDLData(list[i], list[i + 1].toDouble(), list[i + 2]));
    i++;
    i++;
  }
  return data;
}

class GDLData {
  GDLData(this.field, this.value, this.color);
  final String field;
  final double value;
  final Color color;
}
