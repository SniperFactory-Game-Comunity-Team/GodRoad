import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/challenge_upload_controller.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_button.dart';
import 'package:godroad/view/widget/my_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class ChallengeUploadPage extends GetView<ChallengeUploadController> {
  const ChallengeUploadPage({super.key});
  static String route = '/challengeUplad';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black26,
              height: 220,
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
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_circle,
                              size: 50,
                              color: Colors.black,
                            ),
                            Text('이미지를 업로드해주세요.')
                          ],
                        ),
                ),
              ),
            ),
            ListTile(
                title: TextField(
                  onChanged: (value) => controller.checkUpload(),
                  controller: controller.titleController,
                  decoration: const InputDecoration(
                    hintText: '챌린지 제목',
                  ),
                ),
                subtitle: TextField(
                  onChanged: (value) => controller.checkUpload(),
                  controller: controller.subtitleController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '챌린지 부제목',
                      hintStyle: TextStyle(fontSize: 12)),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.calendar);
                  },
                  icon: const FaIcon(FontAwesomeIcons.calendar),
                )),
            const Text('활동 소개'),
            TextField(
              onChanged: (value) => controller.checkUpload(),
              minLines: 10,
              maxLines: 1000,
              controller: controller.contentController,
              decoration: const InputDecoration(
                  hintText: '챌린지를 소개해주세요',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5))),
            ),
            const Text('인증 방법'),
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
                      secondIcon: const FaIcon(FontAwesomeIcons.photoFilm),
                      fisrtFunction: () {
                        controller.testimonyPictureUpload(ImageSource.camera);
                      },
                      secondFunction: () {
                        controller.testimonyPictureUpload(ImageSource.gallery);
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
                      borderSide: BorderSide(color: Colors.black, width: 0.5))),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "인증 횟수",
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  width: 50,
                  height: 35,
                  child: TextFormField(
                    controller: controller.countController,
                    decoration: const InputDecoration(
                      hintText: '0',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.5)),
                      contentPadding: EdgeInsets.all(10),
                    ),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const Text('챌린지 키워드 설정'),
            Wrap(
              children: Keyword.keywords
                  .map((e) => GestureDetector(
                        onTap: () {
                          controller.addKeyword(e);
                        },
                        child: Obx(
                          () => Chip(
                            backgroundColor: controller.isSelected[e] == null
                                ? Colors.grey
                                : controller.isSelected[e]
                                    ? Colors.lightBlue
                                    : Colors.grey,
                            label: Text(e),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            Obx(
              () => CustomButton(
                  text: '등록하기',
                  onPressedFunction: () {
                    controller.uploadChallenge();
                  },
                  isEnabled: controller.isUpload.value),
            )
          ],
        ),
      ),
    );
  }
}
