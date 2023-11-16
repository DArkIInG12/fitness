import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color colors;
  final Color backgroundColor;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClick,
    this.colors = Colors.white,
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      onPressed: onClick,
      child: Text(text, style: TextStyle(fontSize: 20, color: colors)),
    );
  }
}
