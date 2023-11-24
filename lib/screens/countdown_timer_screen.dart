import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/firebase/exercises.dart';
import 'package:fitness/models/countdown_model.dart';
import 'package:fitness/provider.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  ExercisesFirebase? bd;

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

  String twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  Map<String, dynamic>? images;
  int indexImages = 0;
  @override
  Widget build(BuildContext context) {
  var provider = Provider.of<ProviderModel>(context);
    bd = ExercisesFirebase();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    images = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => CountdownModel(
            seconds: 5, items: images!['excercices']['list'].length),
        child: Consumer<CountdownModel>(
          builder: (context, model, child) {
            indexImages = model.currentImageIndex;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: CachedNetworkImageProvider(
                          images!['excercices']['list'][indexImages].gifUrl),
                      width: (MediaQuery.of(context).size.width),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  model.isDiferent2Zero
                      ? 'READY TO GO !'
                      : images!['excercices']['list'][indexImages]
                          .name
                          .toString()
                          .toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromRGBO(0, 0, 255, 1)),
                ),
                Text(
                  model.isDiferent2Zero
                      ? images!['excercices']['list'][indexImages].name
                      : 'x ${images!['excercices']['list'][indexImages].reps.toString()} times',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 40,
                ),
                model.isDiferent2Zero
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CircularProgressIndicator(
                                  value: model.secondsRemaining / model.seconds,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                  strokeWidth: 12,
                                  backgroundColor: Colors.blue,
                                ),
                                Center(
                                  child: Text(
                                    model.secondsRemaining.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 80,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : ButtonWidget(
                        text: 'Done',
                        icono: const Icon(Icons.done),
                        onClick: () {
                          model.updateIndexImage();
                          if (model.currentImageIndex == model.items - 1) {
                            
                            model.isPaused = true;
                            var cal =
                                ((model.secondsIncrease * model.items) / 60)
                                    .toStringAsFixed(1);
                            DateTime now = DateTime.now();
                            String formatedData =
                                '${now.year}-${twoDigits(now.month)}-${twoDigits(now.day)}';
                            Map<String, dynamic> datos = {
                              'user': provider.currentUserEmail,
                              'calories': cal,
                              'time': model.secondsIncrease,
                              'bodyPart': images!['excercices']['bodyPart'],
                              'level': images!['excercices']['level'],
                              'date': formatedData
                            };
                            bd!.insert(datos, 'ejercicios');
                            Navigator.pushNamed(context, '/finalE', arguments: {
                              'time': timeparse(model.secondsIncrease),
                              'num': model.items,
                              'cal': cal,
                              'bodyPart': images!['excercices']['bodyPart'],
                              'level': images!['excercices']['level'],
                            });
                          }
                        },
                        backgroundColor: const Color.fromRGBO(0, 238, 65, 1),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
