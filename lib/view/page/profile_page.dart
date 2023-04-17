import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_button.dart';
import 'package:godroad/view/widget/my_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/my_color.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});
  static String route = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 15,
          ),
        ),
        title: Text(
          '닉네임 설정',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.bottomSheet(
                  MyBottomSheet(
                      firstText: '촬영하기',
                      secondText: '갤러리',
                      firstIcon: const FaIcon(FontAwesomeIcons.camera),
                      secondIcon: const FaIcon(FontAwesomeIcons.photoFilm),
                      fisrtFunction: () {
                        controller.profileUpload(ImageSource.camera);
                      },
                      secondFunction: () {
                        controller.profileUpload(ImageSource.gallery);
                      }),
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
              child: Stack(children: [
                Obx(
                  () => controller.profileUrl.value != ''
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              NetworkImage(controller.profileUrl.value))
                      : const CircleAvatar(
                          radius: 80,
                          backgroundColor: MyColor.lightgrey,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 105,
                          ),
                        ),
                ),
                const Positioned(
                    right: 10,
                    bottom: 10,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey,
                      child: FaIcon(
                        FontAwesomeIcons.camera,
                        size: 30,
                        color: Colors.black,
                      ),
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (value) => controller.uniqueNicknameCheck(),
                    controller: controller.nameController,
                    decoration: const InputDecoration(
                        hintText: '닉네임을 입력해주세요',
                        fillColor: MyColor.lightgrey,
                        filled: true),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Obx(() => controller.isUniqueName.value
                        ? const Text(
                            '사용가능한 닉네임입니다',
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          )
                        : controller.nameController.text != ''
                            ? const Text(
                                '중복된 닉네임입니다.',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              )
                            : const SizedBox()),
                  ),
                ],
              ),
            ),
            Obx(
              () => SizedBox(
                width: 350,
                child: CustomButton(
                    text: '확인',
                    onPressedFunction: () {
                      Get.toNamed(AppRoute.keywordSelect);
                    },
                    isEnabled: controller.isUniqueName.value),
              ),
            )
          ],
        ),
      ),
    );
  }
}
