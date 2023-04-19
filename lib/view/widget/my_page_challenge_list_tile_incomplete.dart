import 'package:flutter/material.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/view/widget/custom_button.dart';

class MyPageChallengeIncompleteListTile extends StatelessWidget {
  const MyPageChallengeIncompleteListTile(
      {super.key, required this.buttontext});
  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 400,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '대학생 서포터즈 모집',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Text(
                    '총 인증 수 ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Text(
                    '15',
                    style: TextStyle(color: MyColor.primary2),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '부족한 인증 수 ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Text(
                    '15',
                    style: TextStyle(color: MyColor.primary2),
                  ),
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
                CustomButton(
                    text: buttontext, onPressedFunction: () {}, isEnabled: true)
              ],
            )
          ],
        ),
      ),
    );
  }
}
