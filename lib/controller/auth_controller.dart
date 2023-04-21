import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/login_controller.dart';
import 'package:godroad/controller/signup_controller.dart';
import 'package:godroad/model/profile.dart';
import 'package:godroad/model/service/firebase.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/widget/login_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  Rxn<Profile> _userProfile = Rxn<Profile>();
  var instance = FirebaseAuth.instance;
  final Rxn<User> _user = Rxn<User>();
  Profile? get userProfile => _userProfile.value;
  User? get user => _user.value;

  userDelete() async {
    Get.find<LoginController>().formKey = GlobalKey<FormState>();
    Get.find<SignUpController>().formKey = GlobalKey<FormState>();
    await user?.delete();
    await Firebase.getUser.doc(_user.value!.uid).delete();
    var challenge = await Firebase.getChallenge.get();
    for (var i = 0; i < challenge.docs.length; i++) {
      Firebase.colChall.doc(challenge.docs[i].data().id).update({
        'participationUserId': FieldValue.arrayRemove([_user.value!.uid]),
        'bookmarkUserId': FieldValue.arrayRemove([_user.value!.uid]),
        'successUserId': FieldValue.arrayRemove([_user.value!.uid]),
      });
    }
  }

  signOut() async {
    Get.find<LoginController>().formKey = GlobalKey<FormState>();
    Get.find<SignUpController>().formKey = GlobalKey<FormState>();
    await instance.signOut();
    await GoogleSignIn().signOut();
  }

  signUp(String email, String pw) {
    instance.createUserWithEmailAndPassword(email: email, password: pw);
  }

  login(String email, String pw) async {
    try {
      await instance
          .signInWithEmailAndPassword(email: email, password: pw)
          .then((value) {
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.dialog(const LoginDialog(content: '등록되지 않은 아이디입니다.'));
      } else if (e.code == 'wrong-password') {
        Get.dialog(const LoginDialog(content: '비밀번호가 옳지 않습니다.'));
      } else {
        log(e.code);
      }
    }
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    var userCredential = await instance.signInWithCredential(credential);
    getProfile();
    return userCredential;
  }

  getOnlyProfile() async {
    var profile = await Firebase.getUser.doc(_user.value!.uid).get();
    _userProfile(profile.data());
  }

  getProfile() async {
    var profile = await Firebase.getUser.doc(_user.value!.uid).get();
    _userProfile(profile.data());
    if (profile.data() != null && profile.data()!.nickname != null) {
      Get.toNamed(AppRoute.main);
    } else {
      Get.toNamed(AppRoute.profile);
    }
  }

  @override
  void onInit() {
    super.onInit();
    instance.authStateChanges().listen((value) {
      _user(value);
      if (value != null) {
        getProfile();
      } else {
        Get.offAllNamed(AppRoute.loginDetail);
      }
    });
  }
}
