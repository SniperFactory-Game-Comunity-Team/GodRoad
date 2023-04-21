import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/bookmark_tile.dart';

class BookmarkPage extends GetView<ProfileController> {
  const BookmarkPage({super.key});
  static String route = '/bookmark';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          title: const Text('북마크한 챌린지'),
        ),
        body: SafeArea(
          child: FutureBuilder<RxList<QueryDocumentSnapshot<Challenge>>?>(
              future: controller.readmyBookmark(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Obx(
                      () => ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return BookmarkTile(
                            buttontext: '참여하기',
                            challenge: snapshot.data![index].data(),
                            onPressed: () {
                              Get.toNamed(AppRoute.challengedetail,
                                  arguments: snapshot.data![index].data());
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(
                          indent: 20,
                          endIndent: 20,
                          thickness: 1,
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: Text('북마크한 챌린지가 없습니다'),
                  );
                }
                return const SpinKitFadingCircle(
                  color: MyColor.primary,
                  size: 30,
                );
              }),
        ));
  }
}
