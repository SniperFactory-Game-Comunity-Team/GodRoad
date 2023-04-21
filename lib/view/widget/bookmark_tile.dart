import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/certification_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/my_color.dart';

class BookmarkTile extends GetView<CertificationController> {
  const BookmarkTile(
      {super.key,
      required this.buttontext,
      required this.challenge,
      this.onPressed});
  final String buttontext;
  final Challenge challenge;
  final Function()? onPressed;

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
              SizedBox(
                width: Get.size.width * 0.65,
                child: Text(
                  challenge.title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Text(
                    int.parse(DateTime.now()
                                .difference(challenge.endDay)
                                .inDays
                                .toString()) ==
                            0
                        ? 'D-day'
                        : 'D${int.parse(DateTime.now().difference(challenge.endDay).inDays.toString()) - 1}',
                    style: const TextStyle(
                      color: MyColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              const Text('총 인증 수', style: TextStyle(fontSize: 10)),
              const SizedBox(width: 3),
              Text(challenge.authenticationCount.toString(),
                  style: const TextStyle(
                      fontSize: 10,
                      height: 1.6,
                      color: MyColor.primary2,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 8)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: challenge.keyword
                    .map((e) => Chip(
                      padding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(
                          horizontal: 0.0, vertical: -4),
                      backgroundColor: MyColor.lightgrey,
                      label: Text(
                        e,
                        style: const TextStyle(fontSize: 10),
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
                child: Text(
                  buttontext,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
