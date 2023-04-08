import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/routes.dart';

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
                child: Text('키워드 설정',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                children: Keyword.keywords
                    .map((e) => GestureDetector(
                          onTap: () {
                            controller.addUserKeyword(e);
                          },
                          child: Obx(
                            () => Chip(
                              backgroundColor: controller.isSelected[e] == null
                                  ? Colors.grey
                                  : controller.isSelected[e]
                                      ? Colors.lightBlue
                                      : Colors.grey,
                              label: Text(e),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.userKeywordUpload();
                  Get.toNamed(AppRoute.main);
                },
                child: const Text('확인'),
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
