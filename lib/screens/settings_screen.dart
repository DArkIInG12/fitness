import 'package:fitness/global_values.dart';
import 'package:fitness/provider.dart';
import 'package:fitness/widgets/general_settings_widget.dart';
import 'package:fitness/widgets/workout_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderModel>(context);
    Widget selectedWidget;

    switch (provider.currentSettings) {
      case 'Workout Settings':
        selectedWidget = workoutSettings();
        break;
      case 'General Settings':
        selectedWidget = generalSettings(context);
        break;
      default:
        selectedWidget = Container();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: GlobalValues.darkTheme.value ? Colors.white : Colors.black,
            )),
        elevation: 1,
        backgroundColor:
            GlobalValues.darkTheme.value ? Colors.black : Colors.white,
        centerTitle: true,
        title: Text(
          provider.currentSettings,
          style: TextStyle(
              color:
                  GlobalValues.darkTheme.value ? Colors.white : Colors.black),
        ),
      ),
      body: selectedWidget,
    );
  }
}
