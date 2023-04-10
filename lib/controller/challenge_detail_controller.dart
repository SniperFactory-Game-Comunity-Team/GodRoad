import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/model/challenge.dart';

class ChallengeDetailController extends GetxController {
  var auth = Get.find<AuthController>();
  RxBool isBookmark = false.obs;
  RxBool isApply = false.obs;
  Rxn<Challenge> detailChallenge = Rxn<Challenge>();

  Future<Rxn<Challenge>> readDetailChallenge(String challengeId) async {
    var challenge = await FirebaseFirestore.instance
        .collection('challenge')
        .doc(challengeId)
        .withConverter(
          fromFirestore: (snapshot, _) => Challenge.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .get();
    detailChallenge(challenge.data());
    return detailChallenge;
  }

  //북마크
  bookMarkCheck(String challengeId) async {
    if (isBookmark.value) {
      await FirebaseFirestore.instance
          .collection('challenge')
          .doc(challengeId)
          .update({'bookmark': FieldValue.increment(1)});
      await FirebaseFirestore.instance
          .collection('profile')
          .doc(auth.user!.uid)
          .update({
        'myBookmark': FieldValue.arrayUnion([challengeId])
      });
    } else {
      await FirebaseFirestore.instance
          .collection('challenge')
          .doc(challengeId)
          .update({'bookmark': FieldValue.increment(-1)});
      await FirebaseFirestore.instance
          .collection('profile')
          .doc(auth.user!.uid)
          .update({
        'myBookmark': FieldValue.arrayRemove([challengeId])
      });
    }
  }

  //챌린지 신청
  applyChallenge(String challengeId)async{
    if (isApply.value) {
      await FirebaseFirestore.instance
          .collection('challenge')
          .doc(challengeId)
          .update({'participationUserId': FieldValue.arrayUnion([auth.user!.uid])});
      await FirebaseFirestore.instance
          .collection('profile')
          .doc(auth.user!.uid)
          .update({
        'myChallenge': FieldValue.arrayUnion([challengeId])
      });
    } else {
      await FirebaseFirestore.instance
          .collection('challenge')
          .doc(challengeId)
          .update({'participationUserId': FieldValue.arrayRemove([auth.user!.uid])});
      await FirebaseFirestore.instance
          .collection('profile')
          .doc(auth.user!.uid)
          .update({
        'myChallenge': FieldValue.arrayRemove([challengeId])
      });
    }
  }
}
