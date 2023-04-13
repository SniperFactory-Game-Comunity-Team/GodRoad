import 'package:flutter/material.dart';

import '../../widget/my_page_challenge_list_tile.dart';

class MyCreateOutsideActivityScreen extends StatelessWidget {
  const MyCreateOutsideActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('MyPageChallengeListTile 데이터 값 손봐야함'),
        Text('대외활동'),
        SizedBox(
          height: 600,
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return MyPageChallengeListTile(
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