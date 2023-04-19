import 'package:flutter/material.dart';
import 'package:godroad/view/widget/my_page_challenge_list_tile_complete.dart';

class CompleteChallengeScreen extends StatelessWidget {
  const CompleteChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 500,
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return MyPageChallengeCompleteListTile(
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
