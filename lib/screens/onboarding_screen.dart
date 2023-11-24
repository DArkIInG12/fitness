import 'package:concentric_transition/concentric_transition.dart';
import 'package:fitness/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      const ItemCardData(
          title: "Get ready to exercise until you get good results",
          subtitle: "Consistency works magic",
          image: AssetImage('assets/images/on1.jpg'),
          backgroundColor: Color.fromRGBO(0, 10, 56, 1),
          titleColor: Colors.pink,
          subtitleColor: Colors.white),
      const ItemCardData(
        title: "This is a path that many begin but few achieve",
        subtitle: "The more difficult the path, the sweeter the victory",
        image: AssetImage('assets/images/on2.jpg'),
        backgroundColor: Colors.white,
        titleColor: Colors.blueAccent,
        subtitleColor: Colors.black,
      ),
      ItemCardData(
          title: "Share your results and your process with your friends",
          subtitle:
              "Changes are noticeable over time, like everything in life.",
          image: const AssetImage('assets/images/on3.jpg'),
          backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
          titleColor: Colors.yellow,
          subtitleColor: Colors.white,
          exitButton: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('firstTime', false);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  "Exit",
                  style: TextStyle(color: Colors.black),
                )),
          ))
    ];

    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return ItemCard(data: data[index]);
        },
      ),
    );
  }
}
