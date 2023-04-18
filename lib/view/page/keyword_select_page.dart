import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SvgPicture.asset('assets/keywordselectpageicon.svg'),
              ),
              const Text(
                '당신이 관심 있는 키워드를\n알려주세요!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: KeywordChip(
                      keyword: Keyword.keywords,
                      onTap: controller.addUserKeyword,
                      isSelected: controller.isSelected,
                      unSelectedBackgroundColor: MyColor.color200,
                      unSelectedTextColor: MyColor.primary2),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 350,
        child: FloatingActionButton.extended(
            backgroundColor: MyColor.primary2,
            elevation: 0,
            onPressed: () {
              Get.toNamed(AppRoute.signupComplete);
            },
            label: const Text('선택완료')),
      ),
    );
  }
}
