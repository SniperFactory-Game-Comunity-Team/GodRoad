import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/challenge_upload_controller.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/view/widget/calendar.dart';
import 'package:godroad/view/widget/custom_button.dart';
import 'package:godroad/view/widget/custom_dialog.dart';
import 'package:godroad/view/widget/keyword_chip.dart';
import 'package:godroad/view/widget/my_bottom_sheet.dart';
import 'package:godroad/view/widget/page_view_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/routes.dart';

class ChallengeUploadPage extends GetView<ChallengeUploadController> {
  const ChallengeUploadPage({super.key});
  static String route = '/challengeUplad';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black26,
              height: 250,
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    MyBottomSheet(
                      firstText: '촬영하기',
                      secondText: '갤러리',
                      firstIcon: const FaIcon(FontAwesomeIcons.camera),
                      secondIcon: const FaIcon(FontAwesomeIcons.photoFilm),
                      fisrtFunction: () {
                        controller.mainPictureUpload(ImageSource.camera);
                      },
                      secondFunction: () {
                        controller.mainPictureUpload(ImageSource.gallery);
                      },
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    clipBehavior: Clip.hardEdge,
                  );
                },
                child: Obx(
                  () => controller.mPicture.value != ''
                      ? Image.network(
                          controller.mPicture.value,
                          fit: BoxFit.cover,
                        )
                      : SvgPicture.asset(
                          'assets/upload_picture.svg',
                          fit: BoxFit.fitWidth,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    onChanged: (value) => controller.checkUpload(),
                    controller: controller.titleController,
                    decoration: const InputDecoration(
                      hintText: '챌린지 제목',
                    ),
                  ),
                  TextField(
                    onChanged: (value) => controller.checkUpload(),
                    controller: controller.subtitleController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '챌린지 부제목',
                        hintStyle: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '활동 소개',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => controller.checkUpload(),
                    minLines: 10,
                    maxLines: 1000,
                    controller: controller.contentController,
                    decoration: const InputDecoration(
                        hintText: '챌린지를 소개해주세요',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5))),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '인증 방법',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    color: Colors.black26,
                    height: 200,
                    child: GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          MyBottomSheet(
                            firstText: '촬영하기',
                            secondText: '갤러리',
                            firstIcon: const FaIcon(FontAwesomeIcons.camera),
                            secondIcon:
                                const FaIcon(FontAwesomeIcons.photoFilm),
                            fisrtFunction: () {
                              controller
                                  .testimonyPictureUpload(ImageSource.camera);
                            },
                            secondFunction: () {
                              controller
                                  .testimonyPictureUpload(ImageSource.gallery);
                            },
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          clipBehavior: Clip.hardEdge,
                        );
                      },
                      child: Obx(
                        () => controller.tPicture.value != ''
                            ? Image.network(
                                controller.tPicture.value,
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.add_circle,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                  Text('인증 사진 예시를 업로드해주세요.')
                                ],
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    onChanged: (value) => controller.checkUpload(),
                    minLines: 10,
                    maxLines: 1000,
                    controller: controller.testimonyContentController,
                    decoration: const InputDecoration(
                        hintText: '인증 예시를 입력해주세요',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5))),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Text(
                        "인증 횟수",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        width: 50,
                        height: 35,
                        child: TextFormField(
                          controller: controller.countController,
                          decoration: const InputDecoration(
                            hintText: '0',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 0.5)),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  PageViewBar(
                      onPressedFirst: () {
                        controller.selectedIndex.value = 0;
                      },
                      onPressedSecond: () {
                        controller.selectedIndex.value = 1;
                      },
                      firstCat: '모집기간',
                      secondCat: '챌린지 기간'),
                  Stack(children: [
                    Container(
                      width: Get.width,
                      height: 5,
                      color: Colors.grey.shade300,
                    ),
                    Obx(() => Positioned(
                          left: controller.selectedIndex.value == 0
                              ? 0
                              : Get.width * 0.45,
                          child: Container(
                            width: Get.width * 0.45,
                            height: 5,
                            color: MyColor.primary,
                          ),
                        ))
                  ]),
                  Obx(() => [
                        Calendar(
                            datenow: controller.datenow,
                            startDay: controller.applyStartDay,
                            endDay: controller.applyEndDay,
                            focusedDay: controller.applyFocusedDay),
                        Calendar(
                          datenow: controller.datenow,
                          startDay: controller.challStartDay,
                          endDay: controller.challEndDay,
                          focusedDay: controller.challFocusedDay,
                        ),
                      ][controller.selectedIndex.value]),
                  const SizedBox(height: 30),
                  const Text(
                    '챌린지 키워드 설정',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  KeywordChip(
                      keyword: Keyword.keywords,
                      onTap: controller.addKeyword,
                      isSelected: controller.isSelected,
                      unSelectedBackgroundColor: MyColor.lightgrey,
                      unSelectedTextColor: Colors.black54),
                  const SizedBox(height: 30),
                  Obx(
                    () => CustomButton(
                        text: '등록하기',
                        onPressedFunction: () async {
                          await controller.uploadChallenge();
                          Get.dialog(CustomDialog(
                            imageRoute: SvgPicture.asset(
                                'assets/dialogsvg/applicationchallenge.svg'),
                            content: '챌린지 등록이 완료되었습니다!',
                            btn2fn: () {
                              Get.toNamed(AppRoute.main);
                            },
                            secondText: '확인',
                          ));
                        },
                        isEnabled: controller.isUpload.value),
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
