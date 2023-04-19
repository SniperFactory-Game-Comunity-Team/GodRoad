import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/util/my_color.dart';

class MyPageChallengeIncompleteListTile extends StatelessWidget {
  const MyPageChallengeIncompleteListTile(
      {super.key, required this.buttontext});
  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: Get.size.width,
        height: Get.size.height * 0.14,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SizedBox(
                    child: Text(
                      '대학생 서포터즈 모집',
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
                  const Text('15',
                      style: TextStyle(
                          fontSize: 10,
                          height: 1.6,
                          color: MyColor.primary2,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  const Text('부족한 인증 수', style: TextStyle(fontSize: 10)),
                  const Text('15',
                      style: TextStyle(
                          fontSize: 10,
                          height: 1.6,
                          color: MyColor.primary2,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Chip(
                        label: Text(
                      '#음악',
                      style: TextStyle(fontSize: 8),
                    )),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8),
                      child: Chip(
                          label: Text(
                        '#취미',
                        style: TextStyle(fontSize: 8),
                      )),
                    ),
                    Chip(
                        label: Text(
                      '#모집완료',
                      style: TextStyle(fontSize: 8),
                    )),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
