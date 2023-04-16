import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExplanationController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);

  RxInt currentPageIndex = 0.obs;
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
}
