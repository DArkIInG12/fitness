import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/models/exercise_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardExcercice extends StatelessWidget {
  CardExcercice({super.key, required this.model});

  ExcerciceModel model;

  @override
  Widget build(BuildContext context) {
    return Container( 
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
          bottom: BorderSide(color: Colors.grey)
        )
      ),
      width: double.infinity,
      height: 110,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.list_rounded),
          const SizedBox(width: 15,),
          Image(image: CachedNetworkImageProvider(model.gifUrl!), height: 90,),
          const SizedBox(width: 15,),
          Expanded(
            child: Text(model.name!,
                style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 16,
                            overflow: TextOverflow.fade
                            )
                ),
          )
        ],
      ),
    );
  }
}
