import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/challenge_detail_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/profile.dart';
import 'package:godroad/util/routes.dart';
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
                        Text(
                          "모집마감 D-${challenge.applyEndDay.day - DateTime.now().day}",
                          style: const TextStyle(
                            fontSize: 15.0,
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
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              snapshot.data!.value!.profileUrl != ''
                                  ? snapshot.data!.value!.profileUrl.toString()
                                  : 'https://picsum.photos/100/100',
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
                  Text(
                    challenge.testimonyContent,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(150, 50),
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
                                                ? const Icon(Icons.bookmark)
                                                : const Icon(
                                                    Icons.bookmark_border),
                                            const SizedBox(width: 2),
                                            Text(snapshots.data!.value!.bookmark
                                                .toString()),
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
                      ElevatedButton(
                        onPressed: () {
                          controller.isApply(!controller.isApply.value);
                          controller.applyChallenge(challenge);
                          Get.toNamed(AppRoute.attendchallengedetail,
                              arguments: challenge);
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                            const Size(150, 50),
                          ),
                        ),
                        child: const Text("참여하기"),
                      ),
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
