import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/service/firebase.dart';
import 'package:godroad/util/keyword.dart';
import 'package:godroad/util/routes.dart';

class MainController extends GetxController {
  var auth = Get.find<AuthController>();
  var profile = Get.find<ProfileController>();
  RxList<QueryDocumentSnapshot<Challenge>> challengeList =
      RxList<QueryDocumentSnapshot<Challenge>>();
  RxList<QueryDocumentSnapshot<Challenge>> challengeMyList =
      RxList<QueryDocumentSnapshot<Challenge>>();
  RxList<QueryDocumentSnapshot<Challenge>> searchChallengeList =
      RxList<QueryDocumentSnapshot<Challenge>>();
  RxInt selectedIndex = 0.obs;
  RxMap isSelected = {}.obs;
  RxList keywords = [].obs;
  var searchcontroller = TextEditingController();
  bool isAttending = false;

  Future<RxList<QueryDocumentSnapshot<Challenge>>?> readChallenge() async {
    var challenge = await Firebase.getChallenge
        .where('isEnd', isEqualTo: false)
        .orderBy('bookmark', descending: true)
        .orderBy('createAt', descending: true)
        .get();
    challengeList(challenge.docs);
    return challengeList.isNotEmpty ? challengeList : null;
  }

  Future<RxList<QueryDocumentSnapshot<Challenge>>?> readMyChallenge() async {
    var challenge = await Firebase.getChallenge
        .where('isEnd', isEqualTo: false)
        .where('keyword', arrayContainsAny: auth.userProfile!.keyword)
        .orderBy('bookmark', descending: true)
        .orderBy('createAt', descending: true)
        .get();
    challengeMyList(challenge.docs);
    return challengeMyList.isNotEmpty ? challengeMyList : null;
  }

  selectKeyword(String keyword) {
    if (keywords.contains(keyword)) {
      keywords.remove(keyword);
      isSelected[keyword] = false;
    } else {
      keywords.add(keyword);
      isSelected[keyword] = true;
    }
  }

  Future<RxList<QueryDocumentSnapshot<Challenge>>?>
      readKeywordChallenge() async {
    var challenge = await Firebase.getChallenge
        .where('isEnd', isEqualTo: false)
        .where('keyword',
            arrayContainsAny:
                keywords.isEmpty ? Keyword.keywords as List : keywords)
        .orderBy('createAt', descending: true)
        .get();
    challengeList(challenge.docs);
    return challengeList.isNotEmpty ? challengeList : null;
  }

  Future<RxList<QueryDocumentSnapshot<Challenge>>?> searchChallenge() async {
    var challenge = await Firebase.getChallenge
        .where('title', isEqualTo: searchcontroller.text)
        .get();
    searchChallengeList(challenge.docs);
    return searchChallengeList.isNotEmpty ? searchChallengeList : null;
  }

  goDetailChallenge(Challenge challenge) async {
    var attendingChall = await Firebase.getChallenge.doc(challenge.id).get();
    if (attendingChall.data() != null) {
      isAttending =
          attendingChall.data()!.participationUserId.contains(auth.user!.uid);
    }
    isAttending
        ? Get.toNamed(AppRoute.attendchallengedetail, arguments: challenge)
        : Get.toNamed(AppRoute.challengedetail, arguments: challenge);
  }

  Future updateChallengeIsEnd() async {
    var challenge = await Firebase.getChallenge.get();
    for (var i = 0; i < challenge.docs.length; i++) {
      Firebase.colChall.doc(challenge.docs[i].data().id).update({
        'isEnd': int.parse(DateTime.now()
                .difference(challenge.docs[i].data().applyEndDay)
                .inDays
                .toString()) >
            0
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    updateChallengeIsEnd();
  }
}
