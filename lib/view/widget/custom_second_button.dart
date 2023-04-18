import 'package:flutter/material.dart';

class CustomSecondButton extends StatelessWidget {
  const CustomSecondButton({
    Key? key,
    required this.text,
    required this.onPressedFunction,
    required this.backgroundColor,
    required this.borderColor,
    required this.textStyle,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    required this.borderCircular,
  }) : super(key: key);
  final String text;
  final Function()? onPressedFunction;
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle textStyle;
  final double left;
  final double right;
  final double top;
  final double bottom;
  final double borderCircular;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        elevation: 0,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderCircular),
          side: BorderSide(color: borderColor),
        ),
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
