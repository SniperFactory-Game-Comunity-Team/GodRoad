import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/signup_controller.dart';
import 'package:godroad/view/widget/custom_button.dart';
import 'package:godroad/view/widget/custom_text_field.dart';

class SignupPage extends GetView<SignUpController> {
  const SignupPage({super.key});
  static String route = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 15,
          ),
        ),
        title: const Text(
          '회원가입',
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side:
                                const BorderSide(width: 1, color: Colors.blue),
                            backgroundColor: Colors.white,
                            fixedSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 24.0, right: 24),
                            child: Text(
                              '취소하기',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Obx(
                        () => SizedBox(
                          width: 130,
                          child: CustomButton(
                              text: '완료',
                              onPressedFunction: () {
                                controller.signUp();
                              },
                              isEnabled: controller.isSignup.value),
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
