import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/view/widget/real_time_tile.dart';
import '../../model/challenge.dart';
import '../../util/routes.dart';

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
        title: Text('실시간 인기 챌린지'),
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
      body: SizedBox(
        height: 550,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>>(
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
            ],
          ),
        ),
      ),
    );
  }
}
