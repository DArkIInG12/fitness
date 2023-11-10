import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:fitness/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget generalSettings(BuildContext context) {
  var provider = Provider.of<ProviderModel>(context);
  return ListView(
    children: [
      ListTile(
        leading: const Icon(Icons.swap_horiz_outlined),
        title: const Text("Theme"),
        trailing: SizedBox(
          width: 80,
          height: 50,
          child: DayNightSwitcher(
            isDarkModeEnabled: provider.darkTheme,
            onStateChanged: (isDarkModeEnabled) {
              provider.darkTheme = !provider.darkTheme;
            },
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.alarm),
        title: const Text("Remind me to work out every day"),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.straighten),
        title: const Text("Metric & Imperial units"),
        onTap: () {},
      )
    ],
  );
}
