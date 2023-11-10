import 'package:flutter/material.dart';

Widget workoutSettings() {
  return ListView(
    children: [
      ListTile(
        leading: const Icon(Icons.coffee),
        title: const Text("Training rest"),
        trailing: const Text(
          "25 secs",
          style: TextStyle(color: Colors.blue),
        ),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.update),
        title: const Text("Countdown time"),
        trailing: const Text(
          "15 secs",
          style: TextStyle(color: Colors.blue),
        ),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.restart_alt),
        title: const Text("Restart progress"),
        onTap: () {},
      )
    ],
  );
}
