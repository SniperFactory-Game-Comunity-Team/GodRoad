import 'package:flutter/material.dart';
import 'package:godroad/view/widget/challenge_list_tile.dart';

class InCompleteChallengeScreen extends StatelessWidget {
  const InCompleteChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ChallengeListTile(
              buttontext: '기록보기',
            );
          },
          separatorBuilder: (context, index) => Divider(
                thickness: 1,
              ),
          itemCount: 4),
    );
  }
}
