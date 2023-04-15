import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/challenge_detail_controller.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/service/firebase.dart';

class UpdateChallengeDetailController extends GetxController {
  var challdetail = Get.find<ChallengeDetailController>();
  var profile = Get.find<ProfileController>();
  var contentController = TextEditingController();
  var testimonyContentController = TextEditingController();
  RxBool isEditContent = false.obs;
  RxBool isEditTestContent = false.obs;

  updateChallenge(Challenge challenge) {
    Firebase.colChall.doc(challenge.id).update({
      'content': contentController.text,
      'testimonyContent': testimonyContentController.text,
    });
  }

  deleteChallenge(Challenge challenge) {
    Firebase.colChall.doc(challenge.id).delete();
  }
}
