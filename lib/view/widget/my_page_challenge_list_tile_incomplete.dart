import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/end_challenge_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/my_color.dart';

class MyPageChallengeIncompleteListTile
    extends GetView<EndChallengeController> {
  const MyPageChallengeIncompleteListTile(
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Text(
                    challenge.title,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Text('총 인증 수', style: TextStyle(fontSize: 10)),
                const SizedBox(width: 3),
                Text(challenge.authenticationCount.toString(),
                    style: const TextStyle(
                        fontSize: 10,
                        height: 1.6,
                        color: MyColor.primary2,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                const Text('남은 인증 수', style: TextStyle(fontSize: 10)),
                const SizedBox(width: 3),
                FutureBuilder(
                    future: controller.getCerCount(challenge),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return Text('${controller.myEndChallCerCount}',
                            style: const TextStyle(
                                fontSize: 10,
                                height: 1.6,
                                color: MyColor.primary2,
                                fontWeight: FontWeight.bold));
                      }
                      return const Text('');
                    }),
              ],
            ),
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
                child: const Text(
                  '기록보기',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
