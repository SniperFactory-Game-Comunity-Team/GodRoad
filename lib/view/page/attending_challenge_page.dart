import 'package:flutter/material.dart';
import 'package:godroad/view/widget/challenge_list_tile.dart';

class AttendingChallengePage extends StatelessWidget {
  const AttendingChallengePage({super.key});
  static String route = '/attendingchallenge';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          elevation: 0,
          title: Text('참여중인 챌린지'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ChallengeListTile(
                buttontext: '인증하기',
              );
            },
            separatorBuilder: (context, index) => Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                ),
            itemCount: 5));
  }
}
