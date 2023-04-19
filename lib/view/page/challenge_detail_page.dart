import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/challenge_detail_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/profile.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_dialog.dart';
import 'package:godroad/view/widget/custom_second_button.dart';
import 'package:godroad/view/widget/custom_second_dialog.dart';
import 'package:intl/intl.dart';

class ChallengeDetailPage extends GetView<ChallengeDetailController> {
  const ChallengeDetailPage({super.key});
  static String route = "/challengedetail";

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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              challenge.mainPicture,
              width: Get.width,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.size.width * 0.35,
                          child: Text(
                            challenge.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: FutureBuilder<Rxn<Profile>>(
                  future: controller.readUploader(challenge),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Row(
                        children: [
                          snapshot.data!.value!.profileUrl != ''
                              ? CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(snapshot
                                      .data!.value!.profileUrl
                                      .toString()),
                                )
                              : const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: MyColor.lightgrey,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.value!.nickname.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                              Text(
                                //'계정 생성 날짜? 챌린지 업로드 날짜?',
                                DateFormat('yyy.M.d. h:mm')
                                    .format(challenge.createAt),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "활동소개",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    challenge.content,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 6,
              color: MyColor.lightgrey,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "인증방법",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      width: 500,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(
                            challenge.testimonyPicture != ''
                                ? challenge.testimonyPicture
                                : 'https://picsum.photos/100/100',
                          ))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      challenge.testimonyContent,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: FutureBuilder(
                          future: controller.readBookmark(challenge),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              return ElevatedButton(
                                onPressed: () {
                                  controller
                                      .isBookmark(!controller.isBookmark.value);
                                  controller.bookMarkCheck(challenge.id);
                                  controller.readChallenge(challenge);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                      left: 35, right: 35, top: 12, bottom: 12),
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                        color: MyColor.primary2),
                                  ),
                                ),
                                child: FutureBuilder(
                                  future: controller.readChallenge(challenge),
                                  builder: (context, snapshots) {
                                    if (snapshots.hasData) {
                                      return Obx(
                                        () => Row(
                                          children: [
                                            snapshot.data!.value
                                                ? const Icon(Icons.bookmark,
                                                    color: MyColor.primary2)
                                                : const Icon(
                                                    Icons.bookmark_border,
                                                    color: MyColor.primary2),
                                            const SizedBox(width: 2),
                                            Text(
                                              snapshots.data!.value!.bookmark
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: MyColor.primary2),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      CustomSecondButton(
                          text: '참여하기',
                          onPressedFunction: () {
                            controller.isApply(!controller.isApply.value);
                            controller.applyChallenge(challenge);
                            Get.dialog(CustomSecondDialog(
                              imageRoute: SvgPicture.asset(
                                  'assets/dialogsvg/applychallenge.svg'),
                              content: '챌린지 신청이 완료되었습니다!',
                              btnfn: () {
                                Get.toNamed(AppRoute.attendchallengedetail,
                                    arguments: challenge);
                              },
                              dialogText: '확인',
                            ));
                          },
                          backgroundColor: MyColor.primary2,
                          borderColor: Colors.transparent,
                          textStyle: const TextStyle(color: Colors.white),
                          left: 35,
                          right: 35,
                          top: 12,
                          bottom: 12,
                          borderCircular: 20),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
