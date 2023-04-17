// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:godroad/util/routes.dart';

class MyPageListTile extends StatelessWidget {
  const MyPageListTile({
    Key? key,
    required this.buttontext,
    required this.count,
    required this.onTap,
  }) : super(key: key);
  final String buttontext;
  final String count;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(buttontext),
        trailing: Row(
          children: [
            Text(count),
            Icon(Icons.chevron_right),
          ],
        ),
        onTap: () {
          onTap;
        },
      ),
    );
  }
}
