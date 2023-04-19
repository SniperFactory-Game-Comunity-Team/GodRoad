import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/my_color.dart';

class RealTimeTile extends GetView<MainController> {
  const RealTimeTile({
    super.key,
    required this.challenge,
  });
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      child: Image(
                        image: NetworkImage(challenge.mainPicture != ''
                            ? challenge.mainPicture
                            : 'https://picsum.photos/100/100'),
                        width: 100,
                        height: 100,
                      )),
                ),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * 0.25,
                          height: 18,
                          child: Text(
                            challenge.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          challenge.subtitle,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          children: challenge.keyword
                              .map((e) => Text(
                                    e,
                                    style: const TextStyle(fontSize: 12),
                                  ))
                              .toList(),
                        ),
                      ],
                    ), //타이틀과 설명을 묶어주는 컴럼
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '모집마감 ',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          Text(
                            int.parse(DateTime.now()
                                        .difference(challenge.applyEndDay)
                                        .inDays
                                        .toString()) ==
                                    0
                                ? 'D-day'
                                : 'D${int.parse(DateTime.now().difference(challenge.applyEndDay).inDays.toString()) - 1}',
                            style: const TextStyle(
                                color: MyColor.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ), //모집마감이랑 디데이를 묶어주는 로우
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.bookmark,
                            size: 15,
                            color: MyColor.color900,
                          ),
                          Text(
                            challenge.bookmark.toString(),
                            style: const TextStyle(
                              color: MyColor.color900,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.goDetailChallenge(challenge);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.color900,
                          fixedSize: const Size(70, 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          "자세히 보기",
                          style: TextStyle(fontSize: 11),
                        ),
                      ), //북마크와 북마크 수를 묶어주는 로우
                    ],
                  ), //모집마감이랑 북마크를 묶어주는 컬럼
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
