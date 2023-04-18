import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/my_color.dart';

class ForTile extends GetView<MainController> {
  const ForTile({
    super.key,
    required this.challenge,
  });
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 7.0),
        child: Card(
          color: Colors.white,
          child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(challenge.mainPicture != ''
                    ? challenge.mainPicture
                    : 'https://picsum.photos/100/100'),
              ),
              title: SizedBox(
                width: Get.size.width * 0.6,
                child: Text(
                  challenge.title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
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
                    backgroundColor: MyColor.primary,
                    fixedSize: const Size(70, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    controller.goDetailChallenge(challenge);
                  },
                  child: const Text(
                    '자세히 보기',
                    style: TextStyle(fontSize: 11),
                  ))),
        ));
  }
}
