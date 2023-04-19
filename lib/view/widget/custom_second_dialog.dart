import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSecondDialog extends StatelessWidget {
  const CustomSecondDialog({
    super.key,
    this.imageRoute,
    required this.content,
    this.dialogText,
    this.btnfn,
  });
  final SvgPicture? imageRoute;
  final String content;
  final String? dialogText;
  final Function()? btnfn;

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(
              thickness: 1,
            ),
            dialogText != null
                ? TextButton(
                    onPressed: btnfn,
                    child: Text(
                      dialogText!,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
