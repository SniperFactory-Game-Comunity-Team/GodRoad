import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/service/firebase.dart';

class EndChallengeController extends GetxController {
  var auth = Get.find<AuthController>();
  RxList<QueryDocumentSnapshot<Challenge>> endSuccessChallengeList =
      RxList<QueryDocumentSnapshot<Challenge>>();
  RxList<QueryDocumentSnapshot<Challenge>> endFailChallengeList =
      RxList<QueryDocumentSnapshot<Challenge>>();

  //성공한 챌린지
  Future<RxList<QueryDocumentSnapshot<Challenge>>?>
      readEndSuccessChallenge() async {
    var challenge = await Firebase.getChallenge
        .where('isEnd', isEqualTo: true)
        .where('successUserId', whereIn: [auth.user!.uid]).get();
    endSuccessChallengeList(challenge.docs);
    return endSuccessChallengeList.isNotEmpty ? endSuccessChallengeList : null;
  }

  //실패한 챌린지
  Future<RxList<QueryDocumentSnapshot<Challenge>>?>
      readEndFailChallenge() async {
    var challenge = await Firebase.getChallenge
        .where('isEnd', isEqualTo: true)
        .where('successUserId', whereNotIn: [auth.user!.uid]).get();
    endFailChallengeList(challenge.docs);
    return endFailChallengeList.isNotEmpty ? endFailChallengeList : null;
  }
}
