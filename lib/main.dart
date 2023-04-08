import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/controller/calendar_controller.dart';
import 'package:godroad/controller/challenge_upload_controller.dart';
import 'package:godroad/controller/login_controller.dart';
import 'package:godroad/controller/main_controller.dart';
import 'package:godroad/controller/profile_controller.dart';
import 'package:godroad/controller/signup_controller.dart';
import 'package:godroad/util/pages.dart';
import 'package:godroad/util/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(LoginController());
        Get.put(SignUpController());
        Get.lazyPut(() => ProfileController(), fenix: true);
        Get.lazyPut(() => MainController(), fenix: true);
        Get.lazyPut(() => ChallengeUploadController(), fenix: true);
        Get.lazyPut(() => CalendarController(), fenix: true);
      }),
      getPages: AppPages.pages,
      initialRoute: AppRoute.login,
    );
  }
}
