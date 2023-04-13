import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/model/certification.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/service/firebase.dart';
import 'package:image_picker/image_picker.dart';

class CertificationController extends GetxController {
  var auth = Get.find<AuthController>();
  RxString cerImg = ''.obs;
  RxList<QueryDocumentSnapshot<Certification>> certificationList =
      RxList<QueryDocumentSnapshot<Certification>>();
  var contentController = TextEditingController();

  setCertification(Challenge challenge) async {
    if (cerImg.value == '') {
      Get.snackbar('인증 실패', '인증사진을 올려주세요');
    } else {
      for (var cerCount = 0;
          cerCount < challenge.authenticationCount;
          cerCount++) {
        var cerId = auth.user!.uid + cerCount.toString();
        await Firebase.colChall
            .doc(challenge.id)
            .collection('certification')
            .doc(cerId)
            .set({
          'id': cerId,
          'challengeId': challenge.id,
          'userId': auth.user!.uid,
          'count': cerCount,
          'img': cerImg.value,
          'content': contentController.text,
          'createAt': Timestamp.now(),
        });
      }
    }
  }

  certificationPictureUpload(ImageSource source) async {
    var res = await ImagePicker().pickImage(source: source);
    if (res != null) {
      Get.back();
      var ref = FirebaseStorage.instance
          .ref('certificationPicture/${auth.user!.uid}');
      TaskSnapshot snapshot = await ref.putFile(File(res.path));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      await auth.user!.updatePhotoURL(downloadUrl);
      cerImg(downloadUrl);
    }
  }

  Future<RxList<QueryDocumentSnapshot<Certification>>> readCertification(
      Challenge challenge, String userId) async {
    var certification = await Firebase.colChall
        .doc(challenge.id)
        .collection('certification')
        .withConverter(
          fromFirestore: (snapshot, _) => Certification.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .where('challengeId', isEqualTo: challenge.id)
        .where('userId', isEqualTo: userId)
        //.orderBy('cerCount', descending: true)
        .get();
    certificationList(certification.docs);
    return certificationList;
  }
}
