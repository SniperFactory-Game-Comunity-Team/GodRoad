import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/routes.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});
  static String route = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: const Icon(Icons.star), //로고 자리
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.auth.userProfile!.nickname}님, 반가워요!',
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '지금 올라온',
                          style: TextStyle(fontSize: 23.0),
                        ),
                        Row(
                          children: const [
                            Text(
                              '챌린지',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23.0,
                              ),
                            ),
                            Text(
                              '를',
                              style: TextStyle(fontSize: 23.0),
                            ),
                          ],
                        ),
                        const Text(
                          '살펴볼까요??',
                          style: TextStyle(fontSize: 23.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Obx(
                      () => CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              controller.auth.userProfile!.profileUrl != ''
                                  ? NetworkImage(controller
                                      .auth.userProfile!.profileUrl
                                      .toString())
                                  : null),
                    ),
                  ],
                ),
                FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>>(
                  future: controller.readChallenge(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Obx(
                        () => ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              // return Obx(
                              //   () => ChallengeListTile(
                              //     challenge: snapshot.data![index].data(),
                              //   ),
                              // );
                              return SizedBox();
                            }),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
