import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/page/screen/challenge_screen.dart';
import '../../model/challenge.dart';
import '../widget/for_tile.dart';

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
        leading: Container(
          margin: EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            'assets/logo.svg',
            width: 100,
            height: 100,
          ),
        ), //로고 자리
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Get.toNamed(AppRoute.challengeUpload);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                //Get.toNamed(AppRoute.attendchallengedetail);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(Get.width * 0.05),
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
                                    '지금 인기있는',
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
                              SvgPicture.asset(
                                'assets/mainpage_image.svg',
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            child: TextField(
                              onSubmitted: (value) =>
                                  Get.toNamed(AppRoute.searchChallenge),
                              controller: controller.searchcontroller,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: '찾으시는 챌린지가 있으신가요?',
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 13.0),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      Get.toNamed(AppRoute.searchChallenge);
                                    },
                                    icon: const Icon(Icons.search)),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 0.5)),
                                contentPadding: const EdgeInsets.all(15),
                              ),
                            ),
                          ),
                          ChallengeScreen(),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              Container(
                color: MyColor.lightgrey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 25, right: 25, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${controller.auth.userProfile!.nickname}님을 위한 챌린지',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('모두보기'),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 300,
                color: MyColor.lightgrey,
                child: SizedBox(
                  height: 200,
                  child:
                      FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>>(
                          future: controller.readMyChallenge(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
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
          ),
        ),
      ),
    );
  }
}
