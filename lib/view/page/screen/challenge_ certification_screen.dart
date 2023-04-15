import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/certification_controller.dart';
import 'package:godroad/model/certification.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/view/widget/certification_button.dart';
import 'package:godroad/view/widget/my_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class ChallengeCertificationScreen extends GetView<CertificationController> {
  const ChallengeCertificationScreen({super.key});
  static String route = '/challengecertification';

  @override
  Widget build(BuildContext context) {
    Challenge challenge = Get.arguments;
    return Padding(
      padding: EdgeInsets.all(Get.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "인증기록",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 35,
            child: FutureBuilder<RxMap<dynamic, dynamic>>(
                future: controller.getCerUpdate(challenge),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: challenge.authenticationCount,
                        itemBuilder: (context, index) {
                          return CertificationButton(
                              text: (index + 1).toString(),
                              index: index,
                              isUpdate: snapshot.data![index.toString()] ?? false.obs);
                        });
                  }
                  return const SizedBox();
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "오늘의 인증",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<RxList<QueryDocumentSnapshot<Certification>>>(
            future: controller.readCertification(challenge),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  height: 300,
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: challenge.authenticationCount,
                    itemBuilder: (context, index) {
                      if (snapshot.data![index].data().img != '') {
                        controller.isUpdate[index.toString()] = true.obs;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  width: Get.width,
                                  height: 180,
                                  child: Image.network(
                                    snapshot.data![index].data().img,
                                    fit: BoxFit.contain,
                                  ),
                                )),
                            Text(snapshot.data![index].data().content)
                          ],
                        );
                      } else {
                        controller.isUpdate[index.toString()] = false.obs;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: Colors.black26,
                                  height: 180,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.bottomSheet(
                                        MyBottomSheet(
                                          firstText: '촬영하기',
                                          secondText: '갤러리',
                                          firstIcon: const FaIcon(
                                              FontAwesomeIcons.camera),
                                          secondIcon: const FaIcon(
                                              FontAwesomeIcons.photoFilm),
                                          fisrtFunction: () {
                                            controller
                                                .certificationPictureUpload(
                                                    ImageSource.camera);
                                          },
                                          secondFunction: () {
                                            controller
                                                .certificationPictureUpload(
                                                    ImageSource.gallery);
                                          },
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
                                      () => controller.cerImg.value != ''
                                          ? Image.network(
                                              controller.cerImg.value,
                                              fit: BoxFit.cover,
                                            )
                                          : SvgPicture.asset(
                                              'assets/upload_picture.svg',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                minLines: 3,
                                maxLines: 500,
                                controller: controller.contentController,
                                decoration: const InputDecoration(
                                    hintText: '500자 이내로 인증 글을 써주세요',
                                    hintStyle: TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0.2))),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    onPageChanged: (index) {
                      controller.currentPageIndex.value = index;
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "팀원 인증 기록",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // SizedBox(
          //   height: 30,
          //   width: Get.width,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: challenge.authenticationCount,
          //     itemBuilder: (context, index) => CertificationButton(
          //       text: (index + 1).toString(),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                controller.updateCertification(
                    challenge, controller.currentPageIndex.value);
              },
              child: const Text("인증하기"),
            ),
          ),
        ],
      ),
    );
  }
}
