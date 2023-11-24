import 'package:fitness/network/apiE.dart';
import 'package:fitness/provider.dart';
import 'package:fitness/widgets/button_widget.dart';
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
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var provider = Provider.of<ProviderModel>(context);
    print('USUARIO: ${provider.userName}');
    apiE = ApiE();
    arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 150,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    arguments!['img'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: Container(
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(0, 0, 255, 1),
                  child: Text(
                    arguments!['bodyPart'].toString().toUpperCase(),
                    style: const TextStyle(
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
          body: Column(
            children: [
              Expanded(
                child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    provider.indexOld = oldIndex;
                    provider.indexNew = newIndex;
                    if (provider.indexOld < provider.indexNew) {
                      provider.indexNew -= 1;
                    }
                    final item = arguments!['list'].removeAt(provider.indexOld);
                    arguments!['list'].insert(provider.indexNew, item);
                  },
                  children: [
                    for (int index = 0;
                        index < arguments!['list'].length;
                        index++)
                      CardExcercice(
                          key: ValueKey(index),
                          model: arguments!['list'][index],
                          level: arguments!['level'])
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ButtonWidget(
                    text: 'Start',
                    onClick: () {
                      Navigator.pushNamed(context, '/coutdown',
                          arguments: {
                            'excercices': arguments!,
                            
                            });
                    },
                    backgroundColor: const Color.fromRGBO(0, 0, 255, 1),
                    icono: const Icon(Icons.play_arrow)),
              )
            ],
          ),
        ));
  }
}
