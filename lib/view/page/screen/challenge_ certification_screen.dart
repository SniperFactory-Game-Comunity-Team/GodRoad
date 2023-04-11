import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/challenge_detail_controller.dart';
import 'package:godroad/view/widget/certification_button.dart';

class ChallengeCertificationScreen extends GetView<ChallengeDetailController> {
  const ChallengeCertificationScreen({super.key});
  static String route = '/challengecertification';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "인증기록",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CertificationButton(
                text: "1",
              ),
              CertificationButton(
                text: "2",
              ),
              CertificationButton(
                text: "3",
              ),
              CertificationButton(
                text: "4",
              ),
              CertificationButton(
                text: "5",
              ),
              CertificationButton(
                text: "6",
              ),
              CertificationButton(
                text: "7",
              ),
              CertificationButton(
                text: "8",
              ),
              CertificationButton(
                text: "9",
              ),
              CertificationButton(
                text: "10",
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "오늘의 인증",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 500,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.pages.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.pages[index]['title'],
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
                onPageChanged: (index) {
                  controller.currentPageIndex.value = index;
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '인증방법\n인증방법\n인증방법',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "팀원 인증 기록",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CertificationButton(
                text: "1",
              ),
              CertificationButton(
                text: "2",
              ),
              CertificationButton(
                text: "3",
              ),
              CertificationButton(
                text: "4",
              ),
              CertificationButton(
                text: "5",
              ),
              CertificationButton(
                text: "6",
              ),
              CertificationButton(
                text: "7",
              ),
              CertificationButton(
                text: "8",
              ),
              CertificationButton(
                text: "9",
              ),
              CertificationButton(
                text: "10",
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("인증하기"),
            ),
          ),
        ],
      ),
    );
  }
}
