import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:godroad/controller/end_challenge_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/my_color.dart';
import 'package:get/get.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/my_page_challenge_list_tile_complete.dart';

class CompleteChallengeScreen extends GetView<EndChallengeController> {
  const CompleteChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.7,
      child: FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>?>(
          future: controller.readEndSuccessChallenge(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return MyPageChallengeCompleteListTile(
                        buttontext: '기록보기',
                        challenge: snapshot.data![index].data(),
                        onPressed: () {
                          Get.toNamed(AppRoute.attendchallengedetail,
                              arguments: snapshot.data![index].data());
                        },
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: Text('성공한 챌린지가 없습니다'),
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
