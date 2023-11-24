import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color colors;
  final Color backgroundColor;
  final Icon icono;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClick,
    required this.icono,
    this.colors = Colors.white,
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
     ElevatedButton.icon(
      icon: icono,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      onPressed: onClick,
      label: Text(text, style: TextStyle(fontSize: 20, color: colors)),
    );
  }
}
