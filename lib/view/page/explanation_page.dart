import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/controller/explanation_controller.dart';
import 'package:godroad/util/routes.dart';

class ExplanationPage extends GetView<ExplanationController> {
  const ExplanationPage({super.key});
  static String route = '/explanation';

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SizedBox(
              height: 600,
              width: 400,
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.pages.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          controller.pages[index]['image'],
                        ),
                      ],
                    ),
                  );
                },
                onPageChanged: (index) {
                  controller.currentPageIndex.value = index;
                },
              ),
            ),
          ),
          floatingActionButton:
              controller.currentPageIndex.value == controller.pages.length - 1
                  ? Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.loginDetail);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.primary2,
                          minimumSize: const Size.fromHeight(10),
                          fixedSize: const Size.fromHeight(55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          '로그인하기',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}
