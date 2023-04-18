import 'package:flutter/material.dart';
import 'package:godroad/util/my_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressedFunction,
    required this.isEnabled,
  }) : super(key: key);
  final String text;
  final Function()? onPressedFunction;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isEnabled ? onPressedFunction : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? MyColor.primary2: Colors.grey,
          fixedSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ));
  }
}
