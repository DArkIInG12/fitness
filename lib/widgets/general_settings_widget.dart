import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:fitness/firebase/messaging.dart';
import 'package:fitness/global_values.dart';
import 'package:fitness/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

PushNotificationProvider notifications = PushNotificationProvider();

List dropItems = [
  "None",
  "7am",
  "9am",
  "11am",
  "1pm",
  "3pm",
  "5pm",
  "7pm",
  "9pm",
];

String currentTopic = "None";

getCurrentTopic() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('currentSub')) {
    currentTopic = prefs.getString('currentSub')!;
  } else {
    prefs.setString('currentSub', 'None');
    currentTopic = prefs.getString('currentSub')!;
  }
}

Widget generalSettings(BuildContext context) {
  var provider = Provider.of<ProviderModel>(context);
  return FutureBuilder(
      future: getCurrentTopic(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.swap_horiz_outlined),
                title: const Text("Theme"),
                trailing: SizedBox(
                  width: 80,
                  height: 50,
                  child: DayNightSwitcher(
                    isDarkModeEnabled: GlobalValues.darkTheme.value,
                    onStateChanged: (isDarkModeEnabled) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('darkTheme', isDarkModeEnabled);
                      GlobalValues.darkTheme.value =
                          !GlobalValues.darkTheme.value;
                      provider.darkmode = !provider.darkmode;
                      provider.notifyListeners();
                    },
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.alarm),
                title: const Text("Remind me to work out every day"),
                trailing: Text(
                  provider.selectedItem == ""
                      ? currentTopic
                      : provider.selectedItem,
                  style: const TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              "Select the time you will be notified to do your workout"),
                          content: DropdownButtonFormField(
                              value: currentTopic,
                              items: dropItems
                                  .map((topic) => DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: topic,
                                      child: Text(topic)))
                                  .toList(),
                              onChanged: (value) {
                                provider.selectedItem = value.toString();
                              }),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  provider.selectedItem =
                                      prefs.getString('currentSub')!;
                                  Navigator.pop(context);
                                },
                                child: const Text("Close")),
                            TextButton(
                                onPressed: () async {
                                  notifications.addNewSubscription(
                                      provider.selectedItem);
                                  currentTopic = provider.selectedItem;
                                  Navigator.pop(context);
                                },
                                child: const Text("Set Hour"))
                          ],
                        );
                      });
                },
              ),
              ListTile(
                leading: const Icon(Icons.straighten),
                title: const Text("Metric & Imperial units"),
                onTap: () {},
              )
            ],
          );
        }
      });
}
