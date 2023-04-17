import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/model/certification.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/profile.dart';
import 'package:godroad/model/service/firebase.dart';
import 'package:godroad/util/routes.dart';
import 'package:image_picker/image_picker.dart';

class CertificationController extends GetxController {
  var auth = Get.find<AuthController>();
  var profile = Get.find<ProfileController>();
  RxString cerImg = ''.obs;
  RxList<QueryDocumentSnapshot<Certification>> certificationList =
      RxList<QueryDocumentSnapshot<Certification>>();
  RxList<QueryDocumentSnapshot<Certification>> memberCertificationList =
      RxList<QueryDocumentSnapshot<Certification>>();
  var contentController = TextEditingController();
  PageController pageController = PageController(viewportFraction: 0.9);
  RxInt currentPageIndex = 0.obs;
  var isUpdate = RxMap<String, RxBool>();
  int cerUpdate = 0;
  int myChallCerCount = 0;
  Rxn<Profile> uploader = Rxn<Profile>();

  setCertification(Challenge challenge) async {
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
        'count': 0,
        'img': '',
        'content': '',
        'createAt': Timestamp.now(),
      });
      isUpdate[cerCount.toString()] = false.obs;
    }
  }

  Future<RxMap<String, RxBool>> getCerUpdate(Challenge challenge) async {
    var cer = await Firebase.colChall
        .doc(challenge.id)
        .collection('certification')
        .withConverter(
          fromFirestore: (snapshot, _) =>
              Certification.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .where('userId', isEqualTo: auth.user!.uid)
        .where('img', isNotEqualTo: '')
        .get();
    cerUpdate = cer.docs.length;
    for (var c = 0; c < cerUpdate; c++) {
      isUpdate[c.toString()] = true.obs;
    }
    return isUpdate;
  }

  Future<int> getCerCount(Challenge challenge) async {
    myChallCerCount = 0;
    var cer = await Firebase.colChall
        .doc(challenge.id)
        .collection('certification')
        .withConverter(
          fromFirestore: (snapshot, _) =>
              Certification.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .where('userId', isEqualTo: auth.user!.uid)
        .where('img', isEqualTo: '')
        .get();
    myChallCerCount = cer.docs.length;
    return myChallCerCount;
  }

  updateCertification(Challenge challenge, int index) {
    if (cerImg.value == '') {
      Get.snackbar('인증 실패', '인증사진을 올려주세요');
    } else {
      Firebase.colChall
          .doc(challenge.id)
          .collection('certification')
          .doc(auth.user!.uid + index.toString())
          .update({
        'img': cerImg.value,
        'content': contentController.text,
        'createAt': Timestamp.now(),
      });
      Firebase.colChall
          .doc(challenge.id)
          .collection('certification')
          .doc(auth.user!.uid + index.toString())
          .update({'count': index});
      profile.readmyChallenge();
      cerImg.value = '';
      contentController.text = '';
      pageController = PageController(viewportFraction: 0.9);
      currentPageIndex(0);
      Get.toNamed(AppRoute.main);
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
      Challenge challenge) async {
    var certification = await Firebase.colChall
        .doc(challenge.id)
        .collection('certification')
        .withConverter(
          fromFirestore: (snapshot, _) =>
              Certification.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .where('userId', isEqualTo: auth.user!.uid)
        .get();
    certificationList(certification.docs);
    return certificationList;
  }

  // 챌린지에 참여한 유저 리스트
  Future<List> readCurrentChallParticipationUser(Challenge challenge) async {
    var curChallParUser = await Firebase.getChallenge.doc(challenge.id).get();
    return curChallParUser.data()!.participationUserId;
  }

  //유저의 인증 리스트
  Future<RxList<QueryDocumentSnapshot<Certification>>> readMemberCertification(
      Challenge challenge, String userId) async {
    var allCertification = await Firebase.colChall
        .doc(challenge.id)
        .collection('certification')
        .withConverter(
          fromFirestore: (snapshot, _) =>
              Certification.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .where('userId', isEqualTo: userId)
        .get();
    memberCertificationList(allCertification.docs);
    return memberCertificationList;
  }

  //유저 아이디로 프로필 가져오기
  Future<Rxn<Profile>> readUploader(Challenge challenge) async {
    var profile = await Firebase.getUser.doc(challenge.userId).get();
    uploader(profile.data());
    return uploader;
  }
  
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    currentPageIndex(0);
  }
}
