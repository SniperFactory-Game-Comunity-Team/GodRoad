import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/keyword_chip.dart';

class KeywordSelectPage extends GetView<ProfileController> {
  const KeywordSelectPage({super.key});
  static String route = '/keywordSelect';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text('키워드 선택',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: KeywordChip(
                    keyword: Keyword.keywords,
                    onTap: controller.addUserKeyword,
                    isSelected: controller.isSelected,
                    unSelectedBackgroundColor: MyColor.color200,
                    unSelectedTextColor: MyColor.primary2),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoute.signupComplete);
                },
                child: const Text('선택완료'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
