import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/certification_controller.dart';
import 'package:godroad/model/certification.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/profile.dart';
import 'package:godroad/util/my_color.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/certification_button.dart';
import 'package:intl/intl.dart';

class MemberCertificationPage extends GetView<CertificationController> {
  const MemberCertificationPage(
      {super.key, required this.userId, required this.challenge});
  final Challenge challenge;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.toNamed(AppRoute.main);
          },
          icon: const Icon(Icons.navigate_before),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.network(
                  challenge.mainPicture,
                  width: Get.width,
                  height: 300,
                  fit: BoxFit.cover,
                ), //임의로 사진 넣음
              ],
            ),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          challenge.subtitle,
                          style: const TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "챌린지 기간 ${DateFormat('yyyy.MM.dd').format(challenge.startDay)} ~ ${DateFormat('yyyy.MM.dd').format(challenge.endDay)}",
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          "모집기간 ${DateFormat('yyyy.MM.dd').format(challenge.applyStartDay)} ~ ${DateFormat('yyyy.MM.dd').format(challenge.applyEndDay)}",
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.auth.userProfile!.nickname.toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                      Text(
                        DateFormat('yyy.M.d. h:mm').format(challenge.createAt),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(Get.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 35,
                        child: FutureBuilder<RxMap<dynamic, dynamic>>(
                            future: controller.getCerUpdate(challenge),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: challenge.authenticationCount,
                                    itemBuilder: (context, index) {
                                      return CertificationButton(
                                          text: (index + 1).toString(),
                                          index: index,
                                          isUpdate: snapshot
                                                  .data![index.toString()] ??
                                              false.obs);
                                    });
                              }
                              return const SizedBox();
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<Rxn<Profile>>(
                        future: controller.readMember(userId),
                        builder: (context, snapshots) {
                          if (snapshots.hasData &&
                              snapshots.connectionState ==
                                  ConnectionState.done) {
                            return Text(
                              '${snapshots.data!.value!.nickname}님의 인증',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<
                          RxList<QueryDocumentSnapshot<Certification>>>(
                        future: controller.readMemberCertification(
                            challenge, userId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            return SizedBox(
                              height: 300,
                              child: PageView.builder(
                                controller: controller.pageController,
                                itemCount: challenge.authenticationCount,
                                itemBuilder: (context, index) {
                                  if (snapshot.data![index].data().img != '') {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Container(
                                                    width: Get.width,
                                                    height: 180,
                                                    color: MyColor.lightgrey,
                                                    child: Image.network(
                                                      snapshot.data![index]
                                                          .data()
                                                          .img,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  )),
                                              const SizedBox(height: 8),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0),
                                                child: Center(
                                                  child: Text(snapshot
                                                      .data![index]
                                                      .data()
                                                      .content),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 0.0),
                                            child: Text(
                                              DateFormat('yy.MM.dd')
                                                  .format(snapshot.data![index]
                                                      .data()
                                                      .createAt)
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                width: Get.width,
                                                height: 180,
                                                color: MyColor.lightgrey,
                                                child: const Center(
                                                    child:
                                                        Text('인증 내용이 없습니다.')),
                                              )),
                                          const SizedBox()
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
                    ],
                  ),
                ),
                const Divider(
                  thickness: 6,
                  color: MyColor.lightgrey,
                ),
                Padding(
                  padding: EdgeInsets.all(Get.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                      FutureBuilder<RxList<Map>>(
                        future: controller
                            .readCurrentChallParticipationUser(challenge),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => MemberCertificationPage(
                                              userId: snapshot
                                                  .data![index]['profile'].id,
                                              challenge: challenge));
                                        },
                                        child: snapshot.data![index]['profile']
                                                    .profileUrl !=
                                                ''
                                            ? CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.grey,
                                                backgroundImage: NetworkImage(
                                                    snapshot
                                                        .data![index]['profile']
                                                        .profileUrl
                                                        .toString()),
                                              )
                                            : const CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    MyColor.lightgrey,
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.grey,
                                                ),
                                              )),
                                  ),
                                ));
                          }
                          return const SizedBox();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
