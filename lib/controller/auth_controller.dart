import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/login_controller.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/controller/signup_controller.dart';
import 'package:godroad/model/profile.dart';
import 'package:godroad/util/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var instance = FirebaseAuth.instance;
  final Rxn<User> _user = Rxn<User>();

  User? get user => _user.value;

  signOut() async {
    await instance.signOut();
    await GoogleSignIn().signOut();
    Get.find<LoginController>().formKey = GlobalKey<FormState>();
    Get.find<SignUpController>().formKey = GlobalKey<FormState>();
    Get.find<ProfileController>().formKey = GlobalKey<FormState>();
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
        Get.snackbar('로그인 실패', '등록되지 않은 이메일입니다');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('로그인 실패', '비밀번호가 틀렸습니다.');
      } else {
        print(e.code);
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

  getProfile() async {
    var profile = await FirebaseFirestore.instance
        .collection('user')
        .doc(_user.value!.uid)
        .withConverter(
          fromFirestore: (snapshot, _) => Profile.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .get();
    if (profile.data() != null && profile.data()!.nickname != null) {
      Get.toNamed(AppRoute.main);
    } else {
      Get.toNamed(AppRoute.profile);
    }
  }

  setProfile(String nickname) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .set({
      'id': user!.uid,
      'nickname': nickname,
      'myClass': '브론즈',
      'email': _user.value!.email,
      'experience': 0,
      'createdAt': Timestamp.now()
    });
    Get.toNamed(AppRoute.main);
  }

  @override
  void onInit() {
    super.onInit();
    instance.authStateChanges().listen((value) {
      _user(value);
      if (value != null) {
        getProfile();
      } else {
        Get.toNamed(AppRoute.login);
      }
    });
  }
}
