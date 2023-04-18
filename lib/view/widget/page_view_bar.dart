import 'package:flutter/material.dart';

class PageViewBar extends StatelessWidget {
  const PageViewBar(
      {super.key,
      required this.onPressedFirst,
      required this.onPressedSecond,
      required this.firstCat,
      required this.secondCat});
  final VoidCallback onPressedFirst;
  final VoidCallback onPressedSecond;
  final String firstCat;
  final String secondCat;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: onPressedFirst,
            child: Text(
              firstCat,
              style: const TextStyle(color: Colors.black),
            )),
        const SizedBox(
          width: 110,
        ),
        TextButton(
            onPressed: onPressedSecond,
            child: Text(secondCat, style: const TextStyle(color: Colors.black))),
      ],
    );
  }
}
