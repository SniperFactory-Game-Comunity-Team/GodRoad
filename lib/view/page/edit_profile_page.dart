import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_button.dart';
import 'package:godroad/view/widget/custom_second_button.dart';
import 'package:godroad/view/widget/custom_dialog.dart';
import 'package:godroad/view/widget/my_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends GetView<ProfileController> {
  const EditProfilePage({super.key});
  static String route = '/editProfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: const Text('프로필 수정'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                            size: 110,
                          ),
                        ),
                ),
                const Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: MyColor.darkgrey,
                      child: FaIcon(
                        FontAwesomeIcons.camera,
                        size: 28,
                        color: Colors.white,
                      ),
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    '닉네임',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) => controller.uniqueNicknameCheck(),
                    controller: controller.nameController,
                    decoration: const InputDecoration(
                      hintText: '닉네임을 입력해주세요',
                      filled: true,
                      fillColor: MyColor.lightgrey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() => controller.isUniqueName.value
                        ? const Text(
                            '사용가능한 닉네임입니다',
                            style: TextStyle(
                              color: MyColor.color700,
                              fontSize: 12,
                            ),
                          )
                        : controller.nameController.text != ''
                            ? const Text(
                                '중복된 닉네임입니다.',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              )
                            : const SizedBox()),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSecondButton(
                    text: '취소하기',
                    onPressedFunction: () {
                      Get.back();
                    },
                    backgroundColor: Colors.transparent,
                    borderColor: MyColor.primary2,
                    textStyle: const TextStyle(
                        color: MyColor.primary2,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    left: 30,
                    right: 30,
                    top: 15,
                    bottom: 15,
                    borderCircular: 15),
                const SizedBox(width: 30),
                Obx(
                  () => SizedBox(
                    width: 120,
                    child: CustomButton(
                        text: '완료',
                        onPressedFunction: () {
                          Get.dialog(CustomDialog(
                            content: '프로필을 수정하시겠습니까?',
                            btn1fn: () {
                              controller.updateProfile();
                              Get.toNamed(AppRoute.my);
                            },
                            btn2fn: () {
                              Get.back();
                            },
                            firstText: '확인',
                            secondText: '취소',
                          ));
                        },
                        isEnabled: controller.isUniqueName.value),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
