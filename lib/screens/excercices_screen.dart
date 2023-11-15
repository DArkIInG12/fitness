import 'package:fitness/models/exercise_model.dart';
import 'package:fitness/network/apiE.dart';
import 'package:fitness/provider.dart';
import 'package:fitness/widgets/card_excercice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExcercicesScreen extends StatefulWidget {
  const ExcercicesScreen({super.key});

  @override
  State<ExcercicesScreen> createState() => _ExcercicesScreenState();
}

class _ExcercicesScreenState extends State<ExcercicesScreen> {
  
  Map<String,dynamic>? arguments;
  ApiE? apiE;


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderModel>(context);
    apiE = ApiE();
    arguments = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(arguments!['bodyPart'].toString())),
      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height * 0.60),
              child: ReorderableListView(
                        onReorder: (int oldIndex, int newIndex) { 
                          provider.indexOld = oldIndex;
                          provider.indexNew = newIndex;
                          if(provider.indexOld < provider.indexNew){
                            provider.indexNew -= 1;
                          }
                          final item = arguments!['list'].removeAt(provider.indexOld);
                          arguments!['list'].insert(provider.indexNew, item);
                         },
                        children: [
                          for(int index = 0; index <arguments!['list'].length; index ++)
                            CardExcercice( key:ValueKey(index) ,
                            model:arguments!['list'][index])
            
                        ]
                        ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                onPressed: (){}, 
                child: const Text('Iniciar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                        ),))
              ],
            )
              ]
        ),
      ),
    );
  }
}
