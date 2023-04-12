import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/profile.dart';
import 'package:godroad/model/service/firebase.dart';

class ChallengeDetailController extends GetxController {
  var auth = Get.find<AuthController>();
  RxInt selectedIndex = 0.obs;
  RxBool isBookmark = false.obs;
  RxBool isApply = false.obs;
  Rxn<Profile> uploader = Rxn<Profile>();
  Rxn<Profile> profileBookmark = Rxn<Profile>();
  Rxn<Challenge> detailChallenge = Rxn<Challenge>();
  final PageController pageController = PageController(initialPage: 0);

  final List<Map<String, dynamic>> pages = [
    {
      'title': '1번 인증',
    },
    {
      'title': '2번 인증',
    },
    {
      'title': '3번 인증',
    },
  ];

  RxInt currentPageIndex = 0.obs;

  Future<Rxn<Profile>> readUploader(Challenge challenge) async {
    var profile = await Firebase.getUser.doc(challenge.userId)
        .get();
    uploader(profile.data());
    return uploader;
  }

  Future<Rxn<Challenge>> readChallenge(Challenge challenge) async {
    var chall = await Firebase.getChallenge.doc(challenge.id)
        .get();
    detailChallenge(chall.data());
    return detailChallenge;
  }

  Future<RxBool> readBookmark(Challenge challenge) async {
    var profile = await Firebase.getUser.doc(auth.user!.uid).get();
    isBookmark(profile.data()!.myBookmark.contains(challenge.id));
    return isBookmark;
  }

  //북마크
  bookMarkCheck(String challengeId) async {
    if (isBookmark.value) {
      await Firebase.colChall
          .doc(challengeId)
          .update({'bookmark': FieldValue.increment(1)});
      await Firebase.colUser
          .doc(auth.user!.uid)
          .update({
        'myBookmark': FieldValue.arrayUnion([challengeId])
      });
    } else {
      await Firebase.colChall
          .doc(challengeId)
          .update({'bookmark': FieldValue.increment(-1)});
      await Firebase.colUser
          .doc(auth.user!.uid)
          .update({
        'myBookmark': FieldValue.arrayRemove([challengeId])
      });
    }
  }

  //챌린지 신청
  applyChallenge(String challengeId) async {
    if (isApply.value) {
      await Firebase.colChall
          .doc(challengeId)
          .update({
        'participationUserId': FieldValue.arrayUnion([auth.user!.uid])
      });
      await Firebase.colUser
          .doc(auth.user!.uid)
          .update({
        'myChallenge': FieldValue.arrayUnion([challengeId])
      });
    } else {
      await Firebase.colChall
          .doc(challengeId)
          .update({
        'participationUserId': FieldValue.arrayRemove([auth.user!.uid])
      });
      await Firebase.colUser
          .doc(auth.user!.uid)
          .update({
        'myChallenge': FieldValue.arrayRemove([challengeId])
      });
    }
  }
}
