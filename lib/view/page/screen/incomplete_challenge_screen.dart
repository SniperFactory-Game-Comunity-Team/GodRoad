import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/view/widget/my_page_challenge_list_tile_complete.dart';
import 'package:godroad/view/widget/my_page_challenge_list_tile_incomplete.dart';

class InCompleteChallengeScreen extends StatelessWidget {
  const InCompleteChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.size.height * 0.8,
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return MyPageChallengeIncompleteListTile(
                  buttontext: '기록보기',
                );
              },
              separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                  ),
              itemCount: 4),
        ),
      ],
    );
  }
}
