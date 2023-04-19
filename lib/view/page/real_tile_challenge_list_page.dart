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
                                fontWeight: FontWeight.bold, fontSize: 15),
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
            FutureBuilder(
              future: controller.readChallenge(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Obx(() => SizedBox(
                          height: Get.size.height * 0.75,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var dataList = snapshot.data!.toSet().toList();
                                return RealTimeTile(
                                  challenge: dataList[index].data(),
                                );
                              }),
                        ));
                  }
                  return const Center(child: Text('실시간 인기 챌린지가 없습니다'));
                }
                return const SpinKitFadingCircle(
                  color: MyColor.primary,
                  size: 30,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
