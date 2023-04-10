import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/view/widget/real_time_tile.dart';

class CreatedChallengePage extends GetView<ProfileController> {
  const CreatedChallengePage({super.key});
  static String route = '/Createdchallenge';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          elevation: 0,
          title: Text('업로드한 챌린지'),
        ),
        body: FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>?>(
            future: controller.readCreatedChallenge(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => RealTimeTile( //업로드한 챌린지 리스트 위젯 필요
                          challenge: snapshot.data![index].data(),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          indent: 20,
                          endIndent: 20,
                          thickness: 1,
                        ));
              }
              return const Center(
                child: Text('업로드한 챌린지가 없습니다'),
              );
            }));
  }
}