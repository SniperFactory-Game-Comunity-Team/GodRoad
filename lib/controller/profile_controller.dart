import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/util/routes.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var auth = Get.find<AuthController>();
  RxString profileUrl = ''.obs;
  RxBool isUniqueName = false.obs;

  Future<bool> isDuplicateUniqueName(String nickname) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('user')
        .where('nickname', isEqualTo: nickname)
        .get();
    if(auth.userProfile != null && auth.userProfile!.nickname == nickname){
      return false;
    }
    return query.docs.isNotEmpty;
  }

  uniqueNicknameCheck() async {
    nameController.text == ''
        ? isUniqueName(false)
        : isUniqueName(!await isDuplicateUniqueName(nameController.text));
  }

  setProfile() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(auth.user!.uid)
        .set({
      'id': auth.user!.uid,
      'nickname': nameController.text,
      'email': auth.user!.email,
      'profileUrl' : profileUrl.value
      //'createdAt': Timestamp.now()
    });
    Get.toNamed(AppRoute.main);
  }

  updateProfile() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(auth.user!.uid)
        .update({
      'nickname': nameController.text,
    });
  }

  profileUpload(ImageSource source) async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: source);
    if (res != null) {
      var ref = FirebaseStorage.instance.ref('profile/${auth.user!.uid}');
      TaskSnapshot snapshot = await ref.putFile(File(res.path));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      await auth.user!.updatePhotoURL(downloadUrl);
      profileUrl(downloadUrl);
    }
  }
}
