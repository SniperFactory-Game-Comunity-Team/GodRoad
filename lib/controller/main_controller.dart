import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/model/challenge.dart';

class MainController extends GetxController {
  var auth = Get.find<AuthController>();
  RxList<QueryDocumentSnapshot<Challenge>> challengeList =
      RxList<QueryDocumentSnapshot<Challenge>>();
  RxList<QueryDocumentSnapshot<Challenge>> challengeMyList =
      RxList<QueryDocumentSnapshot<Challenge>>();
  RxInt selectedIndex = 0.obs;

  Future<RxList<QueryDocumentSnapshot<Challenge>>> readChallenge() async {
    var challenge = await FirebaseFirestore.instance
        .collection('challenge')
        .withConverter(
          fromFirestore: (snapshot, _) => Challenge.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .orderBy('createAt', descending: true)
        .get();
    challengeList(challenge.docs);
    return challengeList;
  }

  Future<RxList<QueryDocumentSnapshot<Challenge>>> readMyChallenge() async {
    var challenge = await FirebaseFirestore.instance
        .collection('challenge')
        .withConverter(
          fromFirestore: (snapshot, _) => Challenge.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .where('keyword', arrayContainsAny: auth.userProfile!.keyword)
        .orderBy('createAt', descending: true)
        .get();
    challengeMyList(challenge.docs);
    return challengeMyList;
  }

  @override
  void onInit() {
    super.onInit();
    readChallenge();
    readMyChallenge();
  }
}
