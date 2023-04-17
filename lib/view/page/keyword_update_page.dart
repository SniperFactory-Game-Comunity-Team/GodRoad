import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/keyword_chip.dart';

class KeywordUpdatePage extends GetView<ProfileController> {
  const KeywordUpdatePage({super.key});
  static String route = '/keywordUpdate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('관심 키워드 변경'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                  height: 150,
                  width: 150,
                  child: SvgPicture.asset(
                    'assets/my_keyword.svg',
                    fit: BoxFit.contain,
                  )),
              const SizedBox(
                height: 20,
              ),
              KeywordChip(
                  keyword: Keyword.keywords,
                  isSelected: controller.isSelected,
                  onTap: controller.addUserKeyword,
                  unSelectedBackgroundColor: MyColor.color200,
                            unSelectedTextColor: MyColor.primary2,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                          left: 35, right: 35, top: 12, bottom: 12),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: MyColor.primary2),
                      ),
                    ),
                    child: const Text(
                      "취소허가",
                      style: TextStyle(
                          color: MyColor.primary2, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.userKeywordUpload();
                      Get.toNamed(AppRoute.my);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                          left: 50, right: 50, top: 12, bottom: 12),
                      elevation: 0,
                      backgroundColor: MyColor.color100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "완료",
                      style: TextStyle(
                          color: MyColor.primary2, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
