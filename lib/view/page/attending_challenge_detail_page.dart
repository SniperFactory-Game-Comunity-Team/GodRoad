import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/challenge_detail_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/view/page/screen/challenge_%20certification_screen.dart';
import 'package:godroad/view/page/screen/challenge_%20information_screen.dart';
import 'package:godroad/view/widget/page_view_bar.dart';
import 'package:intl/intl.dart';

class AttendingChallengeDetailPage extends GetView<ChallengeDetailController> {
  const AttendingChallengeDetailPage({super.key});
  static String route = "/attendchallengedetail";

  @override
  Widget build(BuildContext context) {
    Challenge challenge = Get.arguments;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.network(
                  challenge.mainPicture != ''
                      ? challenge.mainPicture
                      : 'https://picsum.photos/100/100',
                  width: Get.width,
                  height: 300,
                  fit: BoxFit.cover,
                ), //임의로 사진 넣음
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        challenge.subtitle,
                        style: const TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "챌린지 기간 ${DateFormat('yyyy.MM.dd').format(challenge.startDay)} ~ ${DateFormat('yyyy.MM.dd').format(challenge.endDay)}",
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        "모집기간 ${DateFormat('yyyy.MM.dd').format(challenge.applyStartDay)} ~ ${DateFormat('yyyy.MM.dd').format(challenge.applyEndDay)}",
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.auth.userProfile!.nickname.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        //'계정 생성 날짜? 챌린지 업로드 날짜?',
                        DateFormat('yyy.M.d. h:mm').format(challenge.createAt),
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                PageViewBar(
                    onPressedFirst: () {
                      controller.selectedIndex.value = 0;
                    },
                    onPressedSecond: () {
                      controller.selectedIndex.value = 1;
                    },
                    firstCat: '활동 정보',
                    secondCat: '인증 하기'),
                Stack(children: [
                  Container(
                    width: 410,
                    height: 5,
                    color: Colors.grey.shade300,
                  ),
                  Obx(() => Positioned(
                        left: controller.selectedIndex.value == 0 ? 0 : 205,
                        child: Container(
                          width: 205,
                          height: 5,
                          color: Colors.grey,
                        ),
                      ))
                ]),
                Obx(() => [
                      ChallengeInformationScreen(
                        challenge: challenge,
                      ),
                      const ChallengeCertificationScreen()
                    ][controller.selectedIndex.value]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
