import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/view/page/screen/my_create_challenge_screen.dart';
import 'package:godroad/view/page/screen/my_create_outside_activity_screen.dart';

import '../widget/page_view_bar.dart';

class MyCreatePage extends StatelessWidget {
  const MyCreatePage({super.key});
  static String route = '/mycreate';

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 0.obs;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey,
          title: Text('내가 올린 게시물'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PageViewBar(
                  onPressedFirst: () {
                    selectedIndex.value = 0;
                  },
                  onPressedSecond: () {
                    selectedIndex.value = 1;
                  },
                  firstCat: '챌린지',
                  secondCat: '대외활동'),
              Stack(children: [
                Container(
                  width: 410,
                  height: 5,
                  color: Colors.grey.shade300,
                ),
                Obx(() => Positioned(
                      left: selectedIndex.value == 0 ? 0 : 205,
                      child: Container(
                        width: 205,
                        height: 5,
                        color: Colors.grey,
                      ),
                    ))
              ]),
              Obx(() => [
                    const MyCreateChallengeScreen(),
                    const MyCreateOutsideActivityScreen()
                  ][selectedIndex.value]),
            ],
          ),
        ));
  }
}
