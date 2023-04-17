import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/certification_controller.dart';
import 'package:godroad/util/my_color.dart';

class CertificationButton extends GetView<CertificationController> {
  const CertificationButton({
    Key? key,
    required this.isUpdate,
    required this.text,
    required this.index,
  }) : super(key: key);
  final String text;
  final int index;
  final RxBool isUpdate;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.currentPageIndex(index);
          controller.pageController.animateToPage(
            index,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 500),
          );
        },
        child: CircleAvatar(
          backgroundColor: index == controller.currentPageIndex.value
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
