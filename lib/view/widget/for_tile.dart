import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';

class ForTile extends StatelessWidget {
  const ForTile({
    super.key,
    required this.challenge,
  });
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 7.0),
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(challenge.mainPicture != ''
                ? challenge.mainPicture
                : 'https://picsum.photos/100/100'),
          ),
          title: Text(
            challenge.title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          subtitle: Wrap(
            children: challenge.keyword
                .map((e) => GestureDetector(
                      onTap: () {},
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ))
                .toList(),
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: MyColor.primary,
              fixedSize: Size(70, 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              Get.toNamed(AppRoute.challengedetail);
            },
            child: Text(
              '참여하기',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
