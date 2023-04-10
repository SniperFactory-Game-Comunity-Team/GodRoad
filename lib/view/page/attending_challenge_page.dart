import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/view/widget/main_page_challenge_list_tile.dart';

class AttendingChallengePage extends GetView<ProfileController> {
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
        body: FutureBuilder<RxList<Challenge>?>(
            future: controller.readmyChallenge(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => MainPageChallengeListTile(
                        buttontext: '인증하기',
                        challenge: snapshot.data![index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                  ),
                );
              }
              return const Center(
                child: Text('참여 중인 챌린지가 없습니다'),
              );
            }));
  }
}
