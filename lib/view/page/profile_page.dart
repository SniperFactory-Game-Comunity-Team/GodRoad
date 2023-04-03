import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/view/widget/custom_button.dart';
import 'package:godroad/view/widget/custom_text_field.dart';
import 'package:godroad/view/widget/my_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});
  static String route = '/profile';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      onChanged: controller.uniqueNicknameCheck,
      child: Scaffold(
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
                    () => CircleAvatar(
                        radius: 80,
                        backgroundImage: controller.profileUrl.value != ''
                            ? NetworkImage(controller.profileUrl.value)
                            : null),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: controller.nameController,
                    textValidator: controller.nicknameCheck,
                    textHint: '닉네임을 입력해주세요',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
              Obx(
                () => CustomButton(
                    text: '시작하기',
                    onPressedFunction: () {
                      controller.setProfile();
                    },
                    isEnabled: controller.isUniqueName.value),
              )
            ],
          ),
        ),
      ),
    );
  }
}
