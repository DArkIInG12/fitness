import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget settingsWidget(BuildContext context, User user) {
  var provider = Provider.of<ProviderModel>(context);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
          child: CircleAvatar(
              radius: 50, backgroundImage: NetworkImage(user.photoURL!))),
      const SizedBox(
        height: 10,
      ),
      Text(
        user.displayName!,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        user.email!,
        style: const TextStyle(
            color: Colors.grey, fontSize: 18, fontStyle: FontStyle.italic),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //color: const Color.fromRGBO(219, 219, 219, 0.929)
        ),
        width: double.infinity,
        height: 100,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ListTile(
              leading: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.green),
                  //color: Colors.blue,
                  child: const Icon(
                    Icons.water_drop_rounded,
                    color: Colors.white,
                  )),
              title: const Text("Workout Settings"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                provider.currentSettings = "Workout Settings";
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  )),
              title: const Text("General Settings"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                provider.currentSettings = "General Settings";
                Navigator.pushNamed(context, '/settings');
              },
            )
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(
                    const Size(double.infinity, double.infinity))),
            onPressed: () {},
            child: const Text("Sign out")),
      )
    ],
  );
}
