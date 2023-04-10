import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/page/screen/challenge_screen.dart';
import 'package:godroad/view/page/screen/outside_activity_screen.dart';

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
            child: FutureBuilder(
              future: controller.auth.getProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
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
                                    controller.auth.userProfile!.profileUrl !=
                                            ''
                                        ? NetworkImage(controller
                                            .auth.userProfile!.profileUrl
                                            .toString())
                                        : null),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                controller.selectedIndex.value = 0;
                              },
                              child: const Text(
                                '챌린지',
                                style: TextStyle(color: Colors.black),
                              )),
                          const SizedBox(
                            width: 110,
                          ),
                          TextButton(
                              onPressed: () {
                                controller.selectedIndex.value = 1;
                              },
                              child: const Text('대외활동',
                                  style: TextStyle(color: Colors.black))),
                        ],
                      ),
                      Stack(children: [
                        Container(
                          width: 340,
                          height: 5,
                          color: Colors.grey.shade300,
                        ),
                        Obx(() => Positioned(
                              left: controller.selectedIndex.value == 0 ? 0 : 170,
                              child: Container(
                                width: 170,
                                height: 5,
                                color: Colors.grey,
                              ),
                            ))
                      ]),
                      TextField(
                        onSubmitted: (value) =>
                            Get.toNamed(AppRoute.searchChallenge),
                        controller: controller.searchcontroller,
                        decoration: InputDecoration(
                          hintText: 'search..',
                          suffixIcon: IconButton(
                              onPressed: () {
                                Get.toNamed(AppRoute.searchChallenge);
                              },
                              icon: const Icon(Icons.search)),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.5)),
                        ),
                      ),
                      Obx(() => [
                            const ChallengeScreen(),
                            const OutsideActivityScreen()
                          ][controller.selectedIndex.value]),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
