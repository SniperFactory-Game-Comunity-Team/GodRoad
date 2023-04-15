import 'dart:async';
import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:get/get.dart';

class TermDocuController extends GetxController {
  RxBool isFetch = false.obs;
  RxBool isLoading = false.obs;

  final storageRef = FirebaseStorage.instance.ref();
  static const String termOfServiceFilePath = 'terms/term_of_service.txt';
  String? termOfServiceString;

  ///이용약관 assets에 있는 .txt파일을 불러오는 메소드
  Future loadAsset() async {
    if (isFetch.value) return;
    isFetch(true);
    try {
      termOfServiceString =
          await rootBundle.loadString('assets/$termOfServiceFilePath');
    } catch (e) {
      termOfServiceString = '파일을 불러오지 못했습니다.';
      log("[TermDocuController loadAsset Error] $e");
    } finally {
      isFetch(false);
    }
  }

  Future getImageFileFromAssets() async {}
}
