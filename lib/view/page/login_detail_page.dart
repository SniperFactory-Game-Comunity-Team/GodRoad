import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/login_controller.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_button.dart';
import 'package:godroad/view/widget/custom_text_field.dart';
import 'package:godroad/view/widget/term_of_service_widget.dart';

class LoginDetailPage extends GetView<LoginController> {
  const LoginDetailPage({super.key});
  static String route = '/loginDetail';

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: () => controller.checkEmtpy(),
      key: controller.formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 15),
          ),
          title: const Text(
            '로그인',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(),
                    const Text(
                      '계정이 없으신가요?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () => Get.toNamed(AppRoute.signup),
                        child: const Text(
                          '회원가입',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: controller.gooleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColor.primary2,
                      fixedSize: const Size.fromHeight(55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: ListTile(
                      leading: Image.asset('assets/googleicon.png'),
                      title: const Text(
                        '            구글로 로그인하기',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '로그인 하시면 챌리의',
                        style: TextStyle(fontSize: 8),
                      ),
                      TermOfServiceButton(
                          '이용약관, 개인정보 수집 및 이용', Colors.black, 8),
                      Text(
                        '이용약관에 동의한 것으로 간주됩니다.',
                        style: TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
