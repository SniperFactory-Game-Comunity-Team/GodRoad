
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/util/routes.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var idController = TextEditingController();
  var pwController = TextEditingController();
  RxBool islogin = false.obs;
  var auth = Get.find<AuthController>();

  gooleLogin() {
    auth.signInWithGoogle();
  }

  emailLogin() {
    Get.offAndToNamed(AppRoute.loginDetail);
  }

  checkEmtpy() =>
      (formKey.currentState!=null && formKey.currentState!.validate()) ? islogin(true) : islogin(false);

  login() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      auth.login(idController.text, pwController.text);
    }
  }

  idCheck(String id) {
    if (id.isEmpty) {
      return '이메일을 입력해주세요';
    } else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(id)) {
      return '올바르지 않은 이메일입니다.';
    }
    return null;
  }

  pwCheck(String pw) {
    if (pw.isEmpty) {
      return '비밀번호를 입력하세요.';
    } else {
      RegExp regExp = RegExp(
          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');
      if (!regExp.hasMatch(pw)) {
        return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
      } else {
        return null;
      }
    }
  }
}
