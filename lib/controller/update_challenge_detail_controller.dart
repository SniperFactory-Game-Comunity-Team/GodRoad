import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/controller/challenge_detail_controller.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/service/firebase.dart';
import 'package:image_picker/image_picker.dart';

class UpdateChallengeDetailController extends GetxController {
  var auth = Get.find<AuthController>();
  var challdetail = Get.find<ChallengeDetailController>();
  var profile = Get.find<ProfileController>();
  var contentController = TextEditingController();
  var testimonyContentController = TextEditingController();
  RxString mainPic = ''.obs;
  RxBool isEditContent = false.obs;
  RxBool isEditTestContent = false.obs;
  var picker = ImagePicker();

  updateChallenge(Challenge challenge) {
    Firebase.colChall.doc(challenge.id).update({
      'content': contentController.text,
      'testimonyContent': testimonyContentController.text,
      'mainPicture': mainPic.value
    });
  }

   updateMainPicture(ImageSource source) async {
    var res = await picker.pickImage(source: source);
    if (res != null) {
      Get.back();
      var ref =
          FirebaseStorage.instance.ref('testimonyPicture/${auth.user!.uid}');
      TaskSnapshot snapshot = await ref.putFile(File(res.path));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      await auth.user!.updatePhotoURL(downloadUrl);
      mainPic(downloadUrl);
    }
  }

  deleteChallenge(Challenge challenge) {
    Firebase.colChall.doc(challenge.id).delete();
  }
}
