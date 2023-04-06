import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});
  static String route = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Text('메인 페이지'),
          TextButton(onPressed: controller.auth.signOut, child: Text('로그아웃')),
        ],
      )),
    );
  }
}
