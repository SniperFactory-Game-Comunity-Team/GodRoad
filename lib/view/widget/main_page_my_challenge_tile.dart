import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/certification_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/routes.dart';

class MainPageMyChallnegeTile extends GetView<CertificationController> {
  const MainPageMyChallnegeTile({super.key, required this.challenge});
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.attendchallengedetail, arguments: challenge);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(challenge.mainPicture != ''
                          ? challenge.mainPicture
                          : 'https://picsum.photos/150/150'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 25,
                  child: Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black38),
                    child: Center(
                        child: FutureBuilder(
                            future: controller.getCerCount(challenge),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                return Text(
                                  '인증하기(${challenge.authenticationCount - snapshot.data!}/${challenge.authenticationCount}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                );
                              }
                              return const Text('');
                            })),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: SizedBox(
                  width: Get.size.width * 0.36,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.title,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        challenge.subtitle,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  )),
            ),
            Text(
              '챌린지가 끝나기까지 D${int.parse(DateTime.now().difference(challenge.endDay).inDays.toString()) - 1}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
