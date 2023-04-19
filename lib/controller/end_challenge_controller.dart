import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/model/certification.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/service/firebase.dart';

class EndChallengeController extends GetxController {
  var auth = Get.find<AuthController>();
  RxList<QueryDocumentSnapshot<Challenge>> endSuccessChallengeList =
      RxList<QueryDocumentSnapshot<Challenge>>();
  RxList<QueryDocumentSnapshot<Challenge>> endFailChallengeList =
      RxList<QueryDocumentSnapshot<Challenge>>();
  int myEndChallCerCount = 0;

  //성공한 챌린지
  Future<RxList<QueryDocumentSnapshot<Challenge>>?>
      readEndSuccessChallenge() async {
    var challenge = await Firebase.getChallenge
        .where('isEnd', isEqualTo: true)
        .where('successUserId', arrayContainsAny: [auth.user!.uid]).get();
    endSuccessChallengeList(challenge.docs);
    return endSuccessChallengeList.isNotEmpty ? endSuccessChallengeList : null;
  }

  //실패한 챌린지
  Future<RxList<QueryDocumentSnapshot<Challenge>>?>
      readEndChallenge() async {
    var challenge = await Firebase.getChallenge
        .where('isEnd', isEqualTo: true)
        .get();
    endFailChallengeList(challenge.docs);
    return endFailChallengeList.isNotEmpty ? endFailChallengeList : null;
  }

  Future<int> getCerCount(Challenge challenge) async {
    myEndChallCerCount = 0;
    var cer = await Firebase.colChall
        .doc(challenge.id)
        .collection('certification')
        .withConverter(
          fromFirestore: (snapshot, _) =>
              Certification.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .where('userId', isEqualTo: auth.user!.uid)
        .where('img', isEqualTo: '')
        .get();
    myEndChallCerCount = cer.docs.length;
    return myEndChallCerCount;
  }
}
