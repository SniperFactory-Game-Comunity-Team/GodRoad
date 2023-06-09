import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_second_button.dart';
import 'package:godroad/view/widget/keyword_chip.dart';
import 'package:godroad/view/widget/main_page_my_challenge_tile.dart';
import 'package:godroad/view/widget/real_time_tile.dart';

class ChallengeScreen extends GetView<MainController> {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '나의 챌린지',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoute.attending);
                },
                child: const Text(
                  '모두보기',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>?>(
            future: controller.profile.readmyChallenge(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MainPageMyChallnegeTile(
                        challenge: snapshot.data![index].data(),
                      );
                    },
                  );
                }
                return const Center(child: Text('참여 중인 챌린지가 없습니다'));
              }
              return const SpinKitFadingCircle(
                color: MyColor.primary,
                size: 30,
              );
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        clipBehavior: Clip.hardEdge,
                        SizedBox(
                          height: 270,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '키워드 선택',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              KeywordChip(
                                keyword: Keyword.keywords,
                                onTap: controller.selectKeyword,
                                isSelected: controller.isSelected,
                                unSelectedBackgroundColor: MyColor.lightgrey,
                                unSelectedTextColor: Colors.black54,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomSecondButton(
                                    text: '키워드별 챌린지 검색',
                                    onPressedFunction: () {
                                      controller.readKeywordChallenge();
                                      Get.back();
                                    },
                                    backgroundColor: MyColor.primary2,
                                    borderColor: Colors.transparent,
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    left: 35,
                                    right: 35,
                                    top: 12,
                                    bottom: 12,
                                    borderCircular: 20),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(MyColor.primary2),
                    ),
                    child: const Text('키워드 선택'),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black54),
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoute.realtimechallengelist);
                    },
                    child: const Text('모두보기'),
                  )
                ],
              ),
            ],
          ),
        ),
        Obx(
          () => controller.keywords.isEmpty
              ? const SizedBox()
              : SizedBox(
                  height: 30,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: controller.keywords
                        .map((e) => Chip(
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(
                                  color: MyColor.primary,
                                  width: 1.0,
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              label: SizedBox(
                                width: 55,
                                child: Center(
                                  child: Text(
                                    e,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
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
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Obx(
                      () => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
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
                }
                return const SpinKitFadingCircle(
                  color: MyColor.primary,
                  size: 30,
                );
              }),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
