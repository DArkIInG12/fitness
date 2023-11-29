import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// ignore: must_be_immutable
class CardExcercice extends StatelessWidget {
  CardExcercice({super.key, required this.model, required this.level});

  ExcerciceModel model;
  String level;

  int repeticiones() {
    switch (level) {
      case 'BEGGINER':
        return Random().nextInt(15 - 10) + 10;
      case 'INTERMEDIATE':
        return Random().nextInt(30 - 25) + 25;
      case 'ADVANCED':
        return Random().nextInt(60 - 55) + 55;
      default:
        return 25;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (model.reps == 0) {
      model.reps = repeticiones();
    }
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey),
              bottom: BorderSide(color: Colors.grey))),
      width: double.infinity,
      height: 110,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.list_rounded,color: Colors.deepPurple),
          const SizedBox(
            width: 15,
          ),
          Image(
            image: CachedNetworkImageProvider(model.gifUrl!),
            height: 90,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(model.name!.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        overflow: TextOverflow.fade)),
                const SizedBox(
                  height: 10,
                ),
                Text('x ${model.reps!.toString()}',
                style: const TextStyle(color: Colors.black),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
