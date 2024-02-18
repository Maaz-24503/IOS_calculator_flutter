import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      this.backgroundColor = const Color(0xFF333333),
      this.textColor = Colors.white,
      required this.onPressed,
      this.elongated = false,
      required this.text});

  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;
  final bool elongated;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        alignment: elongated?Alignment.centerLeft:Alignment.center,
          backgroundColor: backgroundColor,
          shape: elongated
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)))
              : const CircleBorder(),
          minimumSize: elongated ? const Size(178, 80) : const Size(80, 80)),
      child: Text(
        text,
        style: TextStyle(
            color: textColor, fontSize: 30, fontWeight: FontWeight.w500),
          
      ),
    );
  }
}
