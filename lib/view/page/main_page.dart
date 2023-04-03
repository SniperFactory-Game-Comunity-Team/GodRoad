import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/util/routes.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});
  static String route = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.star), //로고 자리
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.my);
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          const Text('메인 페이지'),
        ],
      )),
    );
  }
}
