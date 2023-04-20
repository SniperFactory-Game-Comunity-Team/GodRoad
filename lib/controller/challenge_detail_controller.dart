import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/controller/certification_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/profile.dart';
import 'package:godroad/model/service/firebase.dart';

class ChallengeDetailController extends GetxController {
  var auth = Get.find<AuthController>();
  var cer = Get.find<CertificationController>();
  RxInt selectedIndex = 0.obs;
  RxBool isBookmark = false.obs;
  RxBool isApply = false.obs;
  Rxn<Profile> uploader = Rxn<Profile>();
  Rxn<Profile> profileBookmark = Rxn<Profile>();
  Rxn<Challenge> detailChallenge = Rxn<Challenge>();

  deleteAttendingChallenge(Challenge challenge) {
    Firebase.colChall.doc(challenge.id).update({
      'participationUserId': FieldValue.arrayRemove([auth.user!.uid])
    });
  }

  Future<Rxn<Profile>> readUploader(Challenge challenge) async {
    var profile = await Firebase.getUser.doc(challenge.userId).get();
    uploader(profile.data());
    return uploader;
  }

  Future<Rxn<Challenge>> readChallenge(Challenge challenge) async {
    var chall = await Firebase.getChallenge.doc(challenge.id).get();
    detailChallenge(chall.data());
    return detailChallenge;
  }

  Future<RxBool> readBookmark(Challenge challenge) async {
    var chall = await Firebase.getChallenge.doc(challenge.id).get();
    chall.data()!.bookmarkUserId.contains(auth.user!.uid);
    isBookmark(chall.data()!.bookmarkUserId.contains(auth.user!.uid));
    return isBookmark;
  }

  //북마크
  bookMarkCheck(String challengeId) async {
    if (isBookmark.value) {
      await Firebase.colChall.doc(challengeId).update({
        'bookmark': FieldValue.increment(1),
        'bookmarkUserId': FieldValue.arrayUnion([auth.user!.uid])
      });
    } else {
      await Firebase.colChall.doc(challengeId).update({
        'bookmark': FieldValue.increment(-1),
        'bookmarkUserId': FieldValue.arrayRemove([auth.user!.uid])
      });
    }
  }

  //챌린지 신청
  applyChallenge(Challenge challenge) async {
    if (isApply.value) {
      await Firebase.colChall.doc(challenge.id).update({
        'participationUserId': FieldValue.arrayUnion([auth.user!.uid]),
        'bookmarkUserId': FieldValue.arrayRemove([auth.user!.uid])
      });
      cer.setCertification(challenge);
    } else {
      await Firebase.colChall.doc(challenge.id).update({
        'participationUserId': FieldValue.arrayRemove([auth.user!.uid])
      });
    }
  }
}
