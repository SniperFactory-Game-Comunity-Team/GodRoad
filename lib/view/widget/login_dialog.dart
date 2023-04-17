import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '로그인 실패',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                content,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
