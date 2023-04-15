import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/for_tile.dart';
import 'package:godroad/view/widget/keyword_chip.dart';
import 'package:godroad/view/widget/main_page_my_challenge_tile.dart';
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
                '나의 챌린지',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoute.attending);
                },
                child: const Text('모두보기'),
              )
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: FutureBuilder(
            future: controller.profile.readmyChallenge(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return MainPageMyChallnegeTile(
                      challenge: snapshot.data![index],
                    );
                  },
                );
              }
              return const Center(child: Text('참여한 챌린지가 없습니다'));
            },
          ),
        ),
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
        OutlinedButton(
          onPressed: () {
            Get.bottomSheet(
              SizedBox(
                height: Get.height * 0.3,
                child: Column(
                  children: [
                    KeywordChip(
                        keyword: Keyword.keywords,
                        onTap: controller.selectKeyword,
                        isSelected: controller.isSelected),
                    ElevatedButton(
                        onPressed: () {
                          controller.startReadKeyword();
                        },
                        child: const Text('키워드별 챌린지 보기'))
                  ],
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              backgroundColor: Colors.white,
              clipBehavior: Clip.hardEdge,
            );
          },
          child: Obx(
            () => controller.keywords.isEmpty
                ? const Text('키워드')
                : Wrap(
                    children: controller.keywords
                        .map((e) => Chip(
                              label: Text(e),
                            ))
                        .toList(),
                  ),
          ),
        ),
        SizedBox(
          height: 400,
          child: FutureBuilder(
              future: controller.readChallenge(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Obx(
                    () => ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length > 3
                            ? 3
                            : snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return RealTimeTile(
                            challenge: snapshot.data![index].data(),
                          );
                        }),
                  );
                }
                return const Center(child: Text('실시간 인기 챌린지가 없습니다'));
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
          height: 50,
          child: Obx(
            () => ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: controller.auth.userProfile!.keyword
                  .map((e) => GestureDetector(
                        onTap: () {},
                        child: Chip(
                          label: Text(e),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>>(
              future: controller.readMyChallenge(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ForTile(
                          challenge: snapshot.data![index].data(),
                        );
                      });
                }
                return const Center(child: Text('추천 챌린지가 없습니다'));
              }),
        ),
      ],
    );
  }
}
