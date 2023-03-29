import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet(
      {super.key,
      required this.firstText,
      required this.secondText,
      required this.firstIcon,
      required this.secondIcon,
      required this.fisrtFunction,
      required this.secondFunction});
  final String firstText;
  final Widget firstIcon;
  final String secondText;
  final Widget secondIcon;
  final Function()? fisrtFunction;
  final Function()? secondFunction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Get.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: fisrtFunction,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                  spacing: 15,
                  children: [
                    firstIcon,
                    Text(
                      firstText,
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: secondFunction,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                  spacing: 15,
                  children: [
                    secondIcon,
                    Text(
                      secondText,
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
