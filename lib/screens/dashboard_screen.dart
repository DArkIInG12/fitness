import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/global_values.dart';
import 'package:fitness/provider.dart';
import 'package:fitness/widgets/report_widget.dart';
import 'package:fitness/widgets/settings_widget.dart';
import 'package:fitness/widgets/training_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key, this.user});
  User? user;

  @override 
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderModel>(context);
    Widget selectedWidget;
 
    switch (provider.currentBody) {
      case 'TRAINING':
        selectedWidget = trainingWidget(context);
        break;
      case 'REPORT':
        selectedWidget = reportWidget();
        break;
      case 'SETTINGS':
        selectedWidget = settingsWidget(context, widget.user!);
        break;
      default:
        selectedWidget = Container();
    }

    return Scaffold(
      backgroundColor:
          GlobalValues.darkTheme.value ? Colors.black : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        backgroundColor:
            GlobalValues.darkTheme.value ? Colors.black : Colors.white,
        title: Text(
          provider.currentBody,
          style: TextStyle(
              color:
                  GlobalValues.darkTheme.value ? Colors.white : Colors.black),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                provider.currentBody = "TRAINING";
              },
              child: SizedBox(
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer_rounded,
                      color: provider.currentBody == "TRAINING"
                          ? Colors.blue
                          : Colors.grey,
                      size: 30,
                    ),
                    Text(
                      "Training",
                      style: TextStyle(
                          color: provider.currentBody == "TRAINING"
                              ? Colors.blue
                              : Colors.grey),
                    )
                  ], 
                ),
              ),
            )),
            Expanded(
              child: InkWell(
                onTap: () {
                  provider.currentBody = "REPORT";
                },
                child: SizedBox(
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bar_chart_rounded,
                        color: provider.currentBody == "REPORT"
                            ? Colors.blue
                            : Colors.grey,
                        size: 30,
                      ),
                      Text(
                        "Report",
                        style: TextStyle(
                            color: provider.currentBody == "REPORT"
                                ? Colors.blue
                                : Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  provider.currentBody = "SETTINGS";
                },
                child: SizedBox(
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: provider.currentBody == "SETTINGS"
                            ? Colors.blue
                            : Colors.grey,
                        size: 30,
                      ),
                      Text(
                        "Settings",
                        style: TextStyle(
                            color: provider.currentBody == "SETTINGS"
                                ? Colors.blue
                                : Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: selectedWidget,
      ),
    );
  }
}
