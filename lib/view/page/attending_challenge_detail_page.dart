import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/view/page/screen/challenge_%20certification_screen.dart';
import 'package:godroad/view/page/screen/challenge_%20information_screen.dart';

class AttendingChallengeDetailPage extends GetView<MainController> {
  const AttendingChallengeDetailPage({super.key});
  static String route = "/attendchallengedetail";

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 0.obs;
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
                  "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzAzMTJfMTk4%2FMDAxNjc4NTk1NzI0MjUx.PPX5LDRE8gOfTuO0THAeE2kQK0i6srapXKXE9QSHZ-og.nS2yJ13pyBfXX2j4OGmIYLgmH0motDoPrVtz34dv6swg.JPEG.arsonne%2F20190526_105935.jpg&type=sc960_832",
                ), //임의로 사진 넣음
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "챌린지 제목",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "챌린지 부제목",
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "챌린지 기간 2023.04.01 ~ 2023.06.21",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        "모집기간 2023.04.01 ~ 2023.06.21",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "D-14",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
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
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "OO음악사",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "2023.04.01 20:23",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          selectedIndex.value = 0;
                        },
                        child: const Text(
                          '활동 정보',
                          style: TextStyle(color: Colors.black),
                        )),
                    const SizedBox(
                      width: 110,
                    ),
                    TextButton(
                        onPressed: () {
                          selectedIndex.value = 1;
                        },
                        child: const Text('인증 하기',
                            style: TextStyle(color: Colors.black))),
                  ],
                ),
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
                      const ChallengeInformationScreen(),
                      const ChallengeCertificationScreen()
                    ][selectedIndex.value]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
