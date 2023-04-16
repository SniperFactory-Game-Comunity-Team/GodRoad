import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/for_tile.dart';
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
                  Get.toNamed(AppRoute.realtimechallengelist);
                },
                child: const Text('모두보기'),
              )
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MainPageMyChallnegeTile();
              }),
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
                    Wrap(
                      children: Keyword.keywords
                          .map((e) => GestureDetector(
                                onTap: () {
                                  controller.selectKeyword(e);
                                },
                                child: Obx(
                                  () => Chip(
                                    backgroundColor:
                                        controller.isSelected[e] == null
                                            ? Colors.grey
                                            : controller.isSelected[e]
                                                ? Colors.lightBlue
                                                : Colors.grey,
                                    label: Text(e),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
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
        const SizedBox(
          height: 20,
        ),
        Container(
          color: MyColor.lightgrey,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 10),
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
        ),
        Container(
          color: MyColor.lightgrey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
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
          ),
        ),
        Container(
          color: MyColor.lightgrey,
          child: SizedBox(
            height: 200,
            child: FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>>(
                future: controller.readMyChallenge(),
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
                  return const SizedBox();
                }),
          ),
        ),
      ],
    );
  }
}
