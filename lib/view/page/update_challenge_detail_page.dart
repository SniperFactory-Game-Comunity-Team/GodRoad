import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/update_challenge_detail_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/profile.dart';
import 'package:godroad/util/my_color.dart';
import 'package:intl/intl.dart';

class UpdateChallengeDetailPage
    extends GetView<UpdateChallengeDetailController> {
  const UpdateChallengeDetailPage({super.key});
  static String route = '/updateChallengeDetail';

  @override
  Widget build(BuildContext context) {
    Challenge challenge = Get.arguments;
    controller.contentController.text = challenge.content;
    controller.testimonyContentController.text = challenge.testimonyContent;
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
              padding: const EdgeInsets.all(15.0),
              child: FutureBuilder<Rxn<Profile>>(
                  future: controller.challdetail.readUploader(challenge),
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
            const Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "활동소개",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller
                              .isEditContent(!controller.isEditContent.value);
                        },
                        child: const Text(
                          '수정하기',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => controller.isEditContent.value
                        ? TextField(
                            minLines: 10,
                            maxLines: 1000,
                            enableInteractiveSelection: true,
                            controller: controller.contentController,
                            decoration: const InputDecoration(
                                hintText: '챌린지 활동을 소개해주세요',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 0.5))),
                          )
                        : Text(
                            controller.contentController.text,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "인증방법",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.isEditTestContent(
                              !controller.isEditTestContent.value);
                        },
                        child: const Text(
                          '수정하기',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
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
                  Obx(
                    () => controller.isEditTestContent.value
                        ? TextField(
                            minLines: 10,
                            maxLines: 1000,
                            controller: controller.testimonyContentController,
                            decoration: const InputDecoration(
                                hintText: '인증 예시를 입력해주세요',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 0.5))),
                          )
                        : Text(
                            controller.testimonyContentController.text,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 35, right: 35, top: 12, bottom: 12),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: MyColor.primary2),
                          ),
                        ),
                        child: const Text(
                          "취소",
                          style: TextStyle(color: MyColor.primary2),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.updateChallenge(challenge);
                          controller.profile.readCreatedChallenge();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 12, bottom: 12),
                          elevation: 0,
                          backgroundColor: MyColor.primary2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("저장하기"),
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
