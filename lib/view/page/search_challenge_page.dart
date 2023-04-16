import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/view/widget/real_time_tile.dart';
import '../../model/challenge.dart';
import '../../util/routes.dart';

class SearchChallengePage extends GetView<MainController> {
  const SearchChallengePage({super.key});
  static String route = '/searchChallenge';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(controller.searchcontroller.text),
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
        child: FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>>(
            future: controller.searchChallenge(),
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
              return const Center(child: Text('정확한 챌린지 제목을 입력해주세요'));
            }),
      ),
    );
  }
}
