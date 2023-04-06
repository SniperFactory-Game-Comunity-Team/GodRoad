import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'challenge_page.dart';
import 'outside_activity_page.dart';

class MainPageViewPage extends StatelessWidget {
  const MainPageViewPage({super.key});
  static String route = '/pageview';

  @override
  Widget build(BuildContext context) {
    final page = [ChallengePage(), OutsideActivityPage()];
    RxInt selectedIndex = 0.obs;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        selectedIndex.value = 0;
                      },
                      child: Text(
                        '챌린지',
                        style: TextStyle(color: Colors.black),
                      )),
                  SizedBox(
                    width: 150,
                  ),
                  TextButton(
                      onPressed: () {
                        selectedIndex.value = 1;
                      },
                      child:
                          Text('대외활동', style: TextStyle(color: Colors.black))),
                ],
              ),
              Stack(children: [
                Container(
                  width: 410,
                  height: 5,
                  color: Colors.grey.shade300,
                ),
                Obx(() => Positioned(
                      left: selectedIndex == 0 ? 0 : 205,
                      child: Container(
                        width: 205,
                        height: 5,
                        color: Colors.grey,
                      ),
                    ))
              ]),
              Obx(() => page[selectedIndex.value])
            ],
          ),
        ),
      ),
    );
  }
}
