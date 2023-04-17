import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';

import '../../util/my_color.dart';
import '../../util/routes.dart';

class SignUpCompletePage extends GetView<ProfileController> {
  const SignUpCompletePage({super.key});
  static String route = '/signupcomplete';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset('assets/signupcomplete.svg'),
            SizedBox(
              height: 40,
            ),
            Text(
              '회원가입이 완료되었습니다!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.setProfile();
                  controller.userKeywordUpload();
                  Get.toNamed(AppRoute.main);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 15, bottom: 15),
                  backgroundColor: MyColor.primary2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  '시작하기',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
