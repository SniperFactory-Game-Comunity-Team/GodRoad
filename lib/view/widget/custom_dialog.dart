import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key, this.title, this.btnOk, required this.content});
  final String? title;
  final String content;
  final Function()? btnOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: title != null
          ? Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(),
            )
          : null,
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(),
      ),
      actions: [
        TextButton(
          onPressed: btnOk,
          child: const Text('확인', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: Get.back,
          child: const Text('취소', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
