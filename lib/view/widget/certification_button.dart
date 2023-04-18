import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/util/my_color.dart';

class CertificationButton extends StatelessWidget {
  const CertificationButton({
    Key? key,
    required this.currentPageIndex,
    required this.pageController,
    required this.isUpdate,
    required this.text,
    required this.index,
  }) : super(key: key);
  final String text;
  final int index;
  final RxBool isUpdate;
  final RxInt currentPageIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          currentPageIndex(index);
          pageController.animateToPage(
            index,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 500),
          );
        },
        child: CircleAvatar(
          backgroundColor: index == currentPageIndex.value
              ? MyColor.primary
              : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundColor:
                  isUpdate.value ? MyColor.primary2 : Colors.blue[100],
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 12,
                    color: isUpdate.value ? Colors.white : MyColor.primary2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
