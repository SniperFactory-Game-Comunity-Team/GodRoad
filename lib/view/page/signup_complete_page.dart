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
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset('assets/signupcomplete.svg'),
              const SizedBox(height: 40),
              const Text(
                '회원가입이 완료되었습니다!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 350,
          child: FloatingActionButton.extended(
            backgroundColor: MyColor.primary2,
            elevation: 0,
            onPressed: () async {
              await controller.setProfile();
              await controller.userKeywordUpload();
              Get.offAndToNamed(AppRoute.main);
            },
            label: const Text('시작하기'),
          ),
        ));
  }
}
