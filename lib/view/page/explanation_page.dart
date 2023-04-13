import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:godroad/view/page/login_page.dart';

import '../../util/routes.dart';

class ExplanationPage extends StatelessWidget {
  static String route = '/explanation';
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);

    final List<Map<String, dynamic>> pages = [
      {
        'image': 'assets/explanation_1.svg',
      },
      {
        'image': 'assets/explanation_2.svg',
      },
      {
        'image': 'assets/explanation_3.svg',
      },
    ];

    RxInt currentPageIndex = 0.obs;
    return Obx(() => Scaffold(
          body: Center(
            child: SizedBox(
              height: 600,
              width: 400,
              child: PageView.builder(
                controller: pageController,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          pages[index]['image'],
                        ),
                      ],
                    ),
                  );
                },
                onPageChanged: (index) {
                  currentPageIndex.value = index;
                },
              ),
            ),
          ),
          floatingActionButton: currentPageIndex.value == pages.length - 1
              ? ElevatedButton(
                  child: Text('로그인하기'),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(300, 30)),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoute.login);
                  },
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}
