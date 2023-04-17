import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.imageRoute,
    required this.content,
    this.firstText,
    this.secondText,
    this.btn1fn,
    this.btn2fn,
  });
  final SvgPicture? imageRoute;
  final String content;
  final String? firstText;
  final String? secondText;
  final Function()? btn1fn;
  final Function()? btn2fn;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: imageRoute,
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        Column(
          children: [
            firstText != null || secondText != null
                ? const Divider(
                    thickness: 1,
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  firstText != null
                      ? TextButton(
                          onPressed: btn1fn,
                          child: Text(
                            firstText!,
                            style: const TextStyle(color: Colors.black),
                          ),
                        )
                      : const SizedBox(),
                  firstText == null || secondText == null
                      ? const SizedBox()
                      : Container(
                          width: 0.5,
                          height: 45,
                          color: Colors.grey,
                        ),
                  secondText != null
                      ? TextButton(
                          onPressed: btn2fn,
                          child: Text(secondText!,
                              style: const TextStyle(color: Colors.black)),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
