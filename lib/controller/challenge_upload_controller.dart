import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/controller/calendar_controller.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChallengeUploadController extends GetxController {
  var auth = Get.find<AuthController>();
  var main = Get.find<MainController>();
  var calendar = Get.find<CalendarController>();
  var picker = ImagePicker();
  var titleController = TextEditingController();
  var subtitleController = TextEditingController();
  var contentController = TextEditingController();
  var testimonyContentController = TextEditingController();
  var countController = TextEditingController();
  SharedPreferences? prefs;
  int saveId = 0;
  RxString mPicture = ''.obs;
  RxString tPicture = ''.obs;
  RxMap isSelected = {}.obs;
  RxBool isUpload = false.obs;
  List<String> keywords = [];
  RxInt authenticationCount = 0.obs;

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
    if (calendar.challEndDay.value.day == DateTime.now().day) {
      Get.snackbar('업로드 실패', '챌린지 기간을 설정해주세요');
    } else if (tPicture.value == '') {
      Get.snackbar('업로드 실패', '인증 사진 예시를 올려주세요');
    } else {
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
        'participationUserId' : [],
        'authenticationCount': int.parse(countController.text),
        'bookmark': 0,
        'createAt': Timestamp.now(),
        'applyStartDay': calendar.applyStartDay.value,
        'applyEndDay': calendar.applyEndDay.value,
        'startDay': calendar.challStartDay.value,
        'endDay': calendar.challEndDay.value,
      });
      main.readChallenge();
      main.readMyChallenge();
      Get.back();
    }
  }

  mainPictureUpload(ImageSource source) async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: source);
    if (res != null) {
      Get.back();
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
      Get.back();
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
