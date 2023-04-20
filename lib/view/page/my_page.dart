import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_dialog.dart';
import 'package:godroad/view/widget/mypage_list_tile.dart';
import 'package:godroad/view/widget/term_of_service_widget.dart';

class MyPage extends GetView<ProfileController> {
  const MyPage({super.key});
  static String route = '/my';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: const Text('마이페이지'),
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoute.main);
          },
          icon: const Icon(Icons.navigate_before),
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        height: Get.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Obx(
                      () => controller.auth.userProfile!.profileUrl != ''
                          ? CircleAvatar(
                              radius: 55,
                              backgroundImage: NetworkImage(controller
                                  .auth.userProfile!.profileUrl
                                  .toString()))
                          : const CircleAvatar(
                              radius: 55,
                              backgroundColor: MyColor.lightgrey,
                              child: Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 80,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      controller.auth.userProfile!.nickname!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      controller.auth.userProfile!.email,
                      style: const TextStyle(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.startEditProfile();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: MyColor.primary2,
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 5, bottom: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        '프로필 수정',
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 0.6,
                  ),
                  MyPageListTile(
                      buttontext: '참여중인 챌린지',
                      onTap: () {
                        Get.toNamed(AppRoute.attending);
                      }),
                  const Divider(
                    thickness: 0.6,
                  ),
                  MyPageListTile(
                      buttontext: '종료된 챌린지',
                      onTap: () {
                        Get.toNamed(AppRoute.endchallenge);
                      }),
                  const Divider(
                    thickness: 0.6,
                  ),
                  MyPageListTile(
                      buttontext: '북마크 목록',
                      onTap: () {
                        Get.toNamed(AppRoute.bookmark);
                      }),
                  const Divider(
                    thickness: 0.6,
                  ),
                  MyPageListTile(
                      buttontext: '관심 키워드 변경',
                      onTap: () {
                        controller.userKeywordUpdate();
                      }),
                  const Divider(
                    thickness: 0.6,
                  ),
                  MyPageListTile(
                      buttontext: '업로드한 게시물들',
                      onTap: () {
                        Get.toNamed(AppRoute.createdChallenge);
                      }),
                  const Divider(
                    thickness: 0.6,
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                height: 60,
                color: MyColor.lightgrey,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.dialog(CustomDialog(
                              imageRoute: SvgPicture.asset(
                                  'assets/dialogsvg/withdrawaccount.svg'),
                              content: '계정 탈퇴 하시겠습니까?',
                              btn1fn: controller.auth.userDelete,
                              btn2fn: Get.back,
                              firstText: '확인',
                              secondText: '취소',
                            ));
                          },
                          child: const Text(
                            '계정 탈퇴',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          )),
                      const SizedBox(width: 10),
                      TextButton(
                          onPressed: () {
                            Get.dialog(CustomDialog(
                              imageRoute: SvgPicture.asset(
                                  'assets/dialogsvg/logoutaccount.svg'),
                              content: '로그아웃 하시겠습니까?',
                              btn1fn: controller.auth.signOut,
                              btn2fn: Get.back,
                              firstText: '확인',
                              secondText: '취소',
                            ));
                          },
                          child: const Text(
                            '로그아웃',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          )),
                      const SizedBox(width: 10),
                      const TermOfServiceButton('이용약관', Colors.black, 12),
                      const SizedBox(width: 10),
                      const TermOfServiceButton('개인정보처리방침', Colors.black, 12)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
