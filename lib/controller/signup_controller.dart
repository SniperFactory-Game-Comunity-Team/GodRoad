import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';

class SignUpController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var idController = TextEditingController();
  var pwController = TextEditingController();
  var pw2Controller = TextEditingController();
  RxBool isSignup = false.obs;
  checkEmtpy() =>
      (formKey.currentState!.validate()) ? isSignup(true) : isSignup(false);
  
  signUp() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Get.find<AuthController>().signUp(idController.text, pw2Controller.text);
    }
  }

  idCheck(String id) {
    if (id.isEmpty) {
      return '이메일을 입력해주세요.';
    } else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(id)) {
      return '올바른 이메일 형식을 입력해주세요';
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

  pw2Check(String pw) {
    if (pw.isEmpty) {
      return '비밀번호를 입력하세요.';
    } else if (!RegExp(
            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$')
        .hasMatch(pw)) {
      return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
    } else if (pw != pwController.text) {
      return '비밀번호가 다릅니다';
    } else {
      return null;
    }
  }
}
