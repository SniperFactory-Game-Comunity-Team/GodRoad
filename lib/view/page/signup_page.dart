import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/signup_controller.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_button.dart';
import 'package:godroad/view/widget/custom_text_field.dart';

class SignupPage extends GetView<SignUpController> {
  const SignupPage({super.key});
  static String route = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        onChanged: () => controller.checkEmtpy(),
        key: controller.formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '회원가입',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: controller.idController,
                    textValidator: controller.idCheck,
                    textHint: '이메일을 입력해주세요',
                  ),
                  CustomTextField(
                    controller: controller.pwController,
                    textValidator: controller.pwCheck,
                    textHint: '비밀번호를 입력해주세요',
                    obscure: true,
                  ),
                  CustomTextField(
                    controller: controller.pw2Controller,
                    textValidator: controller.pw2Check,
                    textHint: '비밀번호를 확인해주세요',
                    obscure: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => CustomButton(
                        text: '회원가입',
                        onPressedFunction: () {
                          controller.signUp();
                          Get.toNamed(AppRoute.profile);
                        },
                        isEnabled: controller.isSignup.value),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoute.loginDetail),
                        child: const Text(
                          '로그인',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
