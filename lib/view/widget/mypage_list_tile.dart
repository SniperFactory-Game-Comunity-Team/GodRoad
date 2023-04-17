// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageListTile extends StatelessWidget {
  const MyPageListTile({
    Key? key,
    required this.buttontext,
    required this.onTap,
  }) : super(key: key);
  final String buttontext;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: ListTile(
        title: Text(
          buttontext,
          style: TextStyle(fontSize: 14),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
