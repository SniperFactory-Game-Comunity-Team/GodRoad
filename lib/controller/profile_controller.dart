import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var auth = Get.find<AuthController>();
  RxString profileUrl = ''.obs;
  RxBool isUniqueName = false.obs;

  Future<bool> isDuplicateUniqueName(String nickname) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('user')
        .where('nickname', isEqualTo: nickname)
        .get();
    return query.docs.isNotEmpty;
  }

  uniqueNicknameCheck() async{
    isUniqueName(!await isDuplicateUniqueName(nameController.text));
    if(!isUniqueName.value){
      Get.snackbar('닉네임 생성 실패', '중복된 닉네임입니다');
    }
  }
  nicknameCheck(String nickname) {
    if (nickname.isEmpty) {
      return '닉네임을 입력해주세요';
    } 
    return null;
  }

  start() {
    auth.setProfile(nameController.text);
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
