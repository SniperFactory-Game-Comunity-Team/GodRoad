import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/login_controller.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_button.dart';
import 'package:godroad/view/widget/custom_text_field.dart';

class LoginDetailPage extends GetView<LoginController> {
  const LoginDetailPage({super.key});
  static String route = '/loginDetail';

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: () => controller.checkEmtpy(),
      key: controller.formKey,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '로그인',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
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
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => CustomButton(
                      text: '로그인',
                      onPressedFunction: () {
                        controller.login();
                      },
                      isEnabled: controller.islogin.value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    TextButton(
                        onPressed: () => Get.toNamed(AppRoute.signup),
                        child: const Text(
                          '회원가입',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
