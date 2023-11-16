import 'package:fitness/network/apiE.dart';
import 'package:fitness/provider.dart';
import 'package:fitness/widgets/card_excercice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ExcercicesScreen extends StatefulWidget {
  const ExcercicesScreen({super.key});

  @override
  State<ExcercicesScreen> createState() => _ExcercicesScreenState();
}

class _ExcercicesScreenState extends State<ExcercicesScreen> {
  Map<String, dynamic>? arguments;
  ApiE? apiE;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var provider = Provider.of<ProviderModel>(context);
    apiE = ApiE();
    arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 150,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                arguments!['bodyPart'].toString().toUpperCase(),
                style: const TextStyle(color: Colors.black),
              ),
              background: Image.network(
                arguments!['img'].toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((_, int indexx) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height * 0.80),
                      child: ReorderableListView(
                          onReorder: (int oldIndex, int newIndex) {
                            provider.indexOld = oldIndex;
                            provider.indexNew = newIndex;
                            if (provider.indexOld < provider.indexNew) {
                              provider.indexNew -= 1;
                            }
                            final item =
                                arguments!['list'].removeAt(provider.indexOld);
                            arguments!['list'].insert(provider.indexNew, item);
                          },
                          children: [
                            for (int index = 0;
                                index < arguments!['list'].length;
                                index++)
                              CardExcercice(
                                  key: ValueKey(index),
                                  model: arguments!['list'][index])
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 45,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/coutdown');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(0, 0, 255, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Iniciar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }, childCount: 1),
          ),
        ],
      ),
    );
  }
}
