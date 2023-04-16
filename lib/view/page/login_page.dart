import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/login_controller.dart';
import 'package:godroad/view/widget/custom_button.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});
  static String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '챌린지 스토리',
                  style: TextStyle(),
                ),
                Text(
                  '챌리',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
            TextButton(onPressed: controller.auth.signOut, child: Text('로그아웃')),
            SizedBox(
              height: Get.width * 0.5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                    text: '이메일로 로그인하기',
                    onPressedFunction: () {
                      controller.emailLogin();
                    },
                    isEnabled: true),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: controller.gooleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    fixedSize: const Size.fromHeight(55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '구글로 로그인하기',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
