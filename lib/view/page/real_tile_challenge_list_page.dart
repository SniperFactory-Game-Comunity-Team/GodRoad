import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/keyword_chip.dart';
import 'package:godroad/view/widget/real_time_tile.dart';

class RealTimeChallengeListPage extends GetView<MainController> {
  const RealTimeChallengeListPage({super.key});
  static String route = '/realtimechallengelist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('실시간 인기 챌린지'),
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
              icon: const Icon(Icons.search),
              onPressed: () {
                // 아이콘 클릭 시 수행할 작업
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
            TextButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(MyColor.color900),
              ),
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
                    ? const Text('키워드 선택하기')
                    : Wrap(
                        children: controller.keywords
                            .map((e) => Chip(
                                  label: Text(e),
                                ))
                            .toList(),
                      ),
              ),
            ),
            FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>>(
              future: controller.readChallenge(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    height: Get.height * 0.8,
                    child: Obx(() => ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return RealTimeTile(
                            challenge: snapshot.data![index].data(),
                          );
                        })),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
