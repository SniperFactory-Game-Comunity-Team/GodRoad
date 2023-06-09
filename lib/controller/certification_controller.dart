import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/model/certification.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/profile.dart';
import 'package:godroad/model/service/firebase.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/custom_second_dialog.dart';
import 'package:image_picker/image_picker.dart';

class CertificationController extends GetxController {
  var auth = Get.find<AuthController>();
  var profile = Get.find<ProfileController>();
  RxString cerImg = ''.obs;
  RxList<QueryDocumentSnapshot<Certification>> certificationList =
      RxList<QueryDocumentSnapshot<Certification>>();
  RxList<QueryDocumentSnapshot<Certification>> memberCertificationList =
      RxList<QueryDocumentSnapshot<Certification>>();
  RxList<Map<String, dynamic>> memberDetail = RxList<Map<String, dynamic>>();
  var contentController = TextEditingController();
  var isUpdate = RxMap<String, RxBool>();
  int cerUpdate = 0;
  int myChallCerCount = 0;
  Rxn<Profile> uploader = Rxn<Profile>();
  Rxn<Profile> member = Rxn<Profile>();

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

  Future<RxMap<String, RxBool>> getCerUpdate(
      Challenge challenge, String userId) async {
    isUpdate.clear();
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

  updateCertification(Challenge challenge, int index) async {
    var chall = await Firebase.getChallenge.doc(challenge.id).get();
    if (chall.data()!.isEnd) {
      Get.snackbar('종료된 챌린지', '종료된 챌린지는 인증을 할 수 없습니다');
    } else if (cerImg.value == '') {
      Get.snackbar('인증 실패', '인증 사진을 올려주세요');
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
      profile.readmyChallenge();
      if (certification.docs.length == index + 1) {
        //챌린지에 성공한 유저 아이디 저장
        Firebase.colChall.doc(challenge.id).update({
          'successUserId': FieldValue.arrayUnion([auth.user!.uid])
        });
        Get.dialog(CustomSecondDialog(
          imageRoute: SvgPicture.asset('assets/dialogsvg/successchallenge.svg'),
          content: '챌리에 성공했습니다!',
          btnfn: () {
            cerImg.value = '';
            contentController.text = '';
            Get.offAndToNamed(AppRoute.main);
          },
          dialogText: '확인',
        ));
      } else {
        Get.dialog(CustomSecondDialog(
          imageRoute:
              SvgPicture.asset('assets/dialogsvg/certificationcomplete.svg'),
          content: '인증이 완료되었습니다!',
          btnfn: () {
            Get.offAndToNamed(AppRoute.main);
            cerImg.value = '';
            contentController.text = '';
          },
          dialogText: '확인',
        ));
      }
    }
  }

  certificationPictureUpload(ImageSource source, int index) async {
    var res = await ImagePicker().pickImage(source: source);
    if (res != null) {
      Get.back();
      var ref = FirebaseStorage.instance
          .ref('certificationPicture/${auth.user!.uid}$index');
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
  Future<RxList<Map<String, dynamic>>> readCurrentChallParticipationUser(
      Challenge challenge) async {
    var curChallParUser = await Firebase.getChallenge.doc(challenge.id).get();
    List userIdList = curChallParUser.data()!.participationUserId;
    memberDetail.clear();
    var i = 0;
    await Future.forEach(userIdList, (element) async {
      memberDetail.add({});
      var profile = await Firebase.getUser.doc(userIdList[i]).get();
      memberDetail[i]['cer'] = userIdList[i];
      memberDetail[i]['profile'] = profile.data();
      i++;
    });
    return memberDetail;
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

  Future<Rxn<Profile>> readMember(String userId) async {
    var profile = await Firebase.getUser.doc(userId).get();
    member(profile.data());
    return member;
  }
}
