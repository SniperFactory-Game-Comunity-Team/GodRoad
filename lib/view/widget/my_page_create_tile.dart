import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/my_color.dart';

class MyPageCreateTile extends StatelessWidget {
  const MyPageCreateTile(
      {super.key, required this.challenge, this.onPressed, this.funDelete});
  final Challenge challenge;
  final Function()? onPressed;
  final Function()? funDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(challenge.title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(
                    Icons.bookmark,
                    color: MyColor.primary,
                  ),
                  SizedBox(
                      width: 25, child: Text(challenge.bookmark.toString())),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Text('참여자 수', style: TextStyle(fontSize: 10)),
              Text(challenge.participationUserId.length.toString(),
                  style: const TextStyle(fontSize: 10)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: challenge.keyword
                    .map((e) => GestureDetector(
                          onTap: () {},
                          child: Chip(
                            padding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                                horizontal: 0.0, vertical: -4),
                            backgroundColor: MyColor.lightgrey,
                            label: Text(
                              e,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 5, bottom: 5),
                  backgroundColor: MyColor.primary2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '수정하기',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}