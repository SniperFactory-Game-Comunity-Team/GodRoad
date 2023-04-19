import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/view/page/screen/complete_challenge_screen.dart';
import 'package:godroad/view/page/screen/incomplete_challenge_screen.dart';
import 'package:godroad/view/widget/page_view_bar.dart';

import '../../util/my_color.dart';

class EndChallengePage extends GetView<ProfileController> {
  static String route = '/endchallenge';
  const EndChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: const Text('종료된 챌린지'),
        ),
        body: Column(
          children: [
            PageViewBar(
                onPressedFirst: () {
                  controller.selectedIndex.value = 0;
                },
                onPressedSecond: () {
                  controller.selectedIndex.value = 1;
                },
                firstCat: '완료',
                secondCat: '미완료'),
            Stack(children: [
              Container(
                width: 410,
                height: 5,
                color: MyColor.lightgrey,
              ),
              Obx(() => Positioned(
                    left: controller.selectedIndex.value == 0 ? 0 : 205,
                    child: Container(
                      width: 205,
                      height: 5,
                      color: MyColor.primary,
                    ),
                  ))
            ]),
            Obx(() => [
                  const CompleteChallengeScreen(),
                  const InCompleteChallengeScreen()
                ][controller.selectedIndex.value]),
          ],
        ));
  }
}
