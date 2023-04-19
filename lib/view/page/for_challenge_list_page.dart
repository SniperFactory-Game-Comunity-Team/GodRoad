import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_second_button.dart';
import 'package:godroad/view/widget/keyword_chip.dart';
import '../../model/challenge.dart';
import '../widget/for_tile.dart';

class ForChallengeListPage extends GetView<MainController> {
  const ForChallengeListPage({super.key});
  static String route = '/forchallengelist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          '${controller.auth.userProfile!.nickname}님을 위한 챌린지',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Get.toNamed(AppRoute.challengeUpload);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Get.toNamed(AppRoute.my);
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>?>(
                future: controller.readMyChallenge(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Obx(
                        () => ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length < 3
                                ? snapshot.data!.length
                                : 3,
                            itemBuilder: (context, index) {
                              return ForTile(
                                challenge: snapshot.data![index].data(),
                              );
                            }),
                      );
                    }
                    return const Center(child: Text('추천 챌린지가 없습니다'));
                  }
                  return const SpinKitFadingCircle(
                    color: MyColor.primary,
                    size: 30,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
