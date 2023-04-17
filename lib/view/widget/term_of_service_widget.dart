import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/term_docu_controller.dart';

class TermOfServiceButton extends GetView<TermDocuController> {
  const TermOfServiceButton(this.title, this.color, this.size, {super.key});
  final String title;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (!Get.isRegistered<TermDocuController>()) {
            Get.put(TermDocuController());
          }
          if (controller.termOfServiceString == null) {
            controller.loadAsset();
          }

          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enableDrag: true,
            isScrollControlled: true,
            builder: (context) {
              return SizedBox(
                height: Get.size.height / 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Center(
                          child: Container(
                            width: Get.size.width / 5,
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => !controller.isFetch.value
                            ? SizedBox(
                                height: Get.size.height / 1.8,
                                child: SingleChildScrollView(
                                    child: Text(
                                        '${controller.termOfServiceString}')),
                              )
                            : const Center(child: CupertinoActivityIndicator()),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Text(
          title,
          style: TextStyle(color: color, fontSize: size),
        ));
  }
}
