import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChallengeUploadController extends GetxController {
  var auth = Get.find<AuthController>();
  var picker = ImagePicker();
  var titleController = TextEditingController();
  var subtitleController = TextEditingController();
  var contentController = TextEditingController();
  var testimonyContentController = TextEditingController();
  SharedPreferences? prefs;
  int saveId = 0;
  RxString mPicture = ''.obs;
  RxString tPicture = ''.obs;
  RxMap isSelected = {}.obs;
  RxBool isUpload = false.obs;
  List<String> keywords = [];

  checkUpload() => (contentController.text != '' &&
          titleController.text != '' &&
          subtitleController.text != '' &&
          testimonyContentController.text != '')
      ? isUpload(true)
      : isUpload(false);

  addKeyword(String keyword) {
    if (keywords.contains(keyword)) {
      keywords.remove(keyword);
      isSelected[keyword] = false;
    } else {
      keywords.add(keyword);
      isSelected[keyword] = true;
    }
  }

  uploadChallenge() async {
    saveId++;
    if (prefs != null) {
      prefs!.setInt('saveId', saveId);
    }
    String id = auth.user!.uid + saveId.toString();
    await FirebaseFirestore.instance.collection('challenge').doc(id).set({
      'id': id,
      'userId': auth.user!.uid,
      'title': titleController.text,
      'subtitle': subtitleController.text,
      'content': contentController.text,
      'mainPicture': mPicture.value,
      'testimonyPicture': tPicture.value,
      'testimonyContent': testimonyContentController.text,
      'keyword': keywords,
      //'createAt' : Timestamp.now()
    });
    Get.back();
  }

  mainPictureUpload(ImageSource source) async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: source);
    if (res != null) {
      var ref = FirebaseStorage.instance.ref('mainPicture/${auth.user!.uid}');
      TaskSnapshot snapshot = await ref.putFile(File(res.path));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      await auth.user!.updatePhotoURL(downloadUrl);
      mPicture(downloadUrl);
    }
  }

  testimonyPictureUpload(ImageSource source) async {
    var res = await picker.pickImage(source: source);
    if (res != null) {
      var ref =
          FirebaseStorage.instance.ref('testimonyPicture/${auth.user!.uid}');
      TaskSnapshot snapshot = await ref.putFile(File(res.path));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      await auth.user!.updatePhotoURL(downloadUrl);
      tPicture(downloadUrl);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      saveId = prefs!.getInt('saveId') ?? 0;
    }
  }
}
