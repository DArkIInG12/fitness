
import 'package:fitness/models/countdown_model.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChangeNotifierProvider(
                create: (context) => CountdownModel(seconds: 60),
                child: Consumer<CountdownModel>(
                  builder: (context, model, child) {
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: model.secondsRemaining/model.seconds,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 12,
                            backgroundColor: Colors.greenAccent,

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
                          const SizedBox(
                            height: 80,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonWidget(
                                  onClick: () {
                                    model.togglePause();
                                  },
                                  text: model.isPaused ? 'Resume' :'Pause'),
                              const SizedBox(width: 20,),
                              ButtonWidget(text: 'Cancel', onClick: (){})
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
