import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/end_challenge_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/my_page_challenge_list_tile_incomplete.dart';

class InCompleteChallengeScreen extends GetView<EndChallengeController> {
  const InCompleteChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.7,
      child: FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>?>(
          future: controller.readEndChallenge(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      if (!snapshot.data![index]
                              .data()
                              .successUserId
                              .contains(controller.auth.user!.uid) &&
                          snapshot.data![index]
                              .data()
                              .participationUserId
                              .contains(controller.auth.user!.uid)) {
                        return MyPageChallengeIncompleteListTile(
                          buttontext: '기록보기',
                          challenge: snapshot.data![index].data(),
                          onPressed: () {
                            Get.toNamed(AppRoute.attendchallengedetail,
                                arguments: snapshot.data![index].data());
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                );
              }
              return const Center(
                child: Text('미완료된 챌린지가 없습니다'),
              );
            }
            return const SpinKitFadingCircle(
              color: MyColor.primary,
              size: 30,
            );
          }),
    );
  }
}
