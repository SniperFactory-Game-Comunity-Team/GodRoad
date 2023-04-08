import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/for_tile.dart';
import 'package:godroad/view/widget/real_time_tile.dart';

class ChallengeScreen extends GetView<MainController> {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '실시간 인기 챌린지',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoute.realtimechallengelist);
                },
                child: const Text('모두보기'),
              )
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>>(
              future: controller.readChallenge(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return RealTimeTile(
                          challenge: snapshot.data![index].data(),
                        );
                      }));
                }
                return const SizedBox();
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${controller.auth.userProfile!.nickname}님을 위한 챌린지',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('모두보기'),
              )
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>>(
              future: controller.readChallenge(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ForTile(
                          challenge: snapshot.data![index].data(),
                        );
                      }));
                }
                return SizedBox();
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '키워드로 모아보기',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Wrap(
                children: Keyword.keywords
                    .map((e) => GestureDetector(
                          onTap: () {},
                          child: Chip(
                            label: Text(e),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
