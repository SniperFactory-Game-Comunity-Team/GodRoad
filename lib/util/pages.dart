import 'package:get/get.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/page/calendar_page.dart';
import 'package:godroad/view/page/challenge_upload_page.dart';
import 'package:godroad/view/page/keyword_select_page.dart';
import 'package:godroad/view/page/keyword_update_page.dart';
import 'package:godroad/view/page/login_detail_page.dart';
import 'package:godroad/view/page/login_page.dart';
import 'package:godroad/view/page/main_page.dart';
import 'package:godroad/view/page/permission_page.dart';
import 'package:godroad/view/page/edit_profile_page.dart';
import 'package:godroad/view/page/my_page.dart';
import 'package:godroad/view/page/profile_page.dart';
import 'package:godroad/view/page/signup_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoute.main, page: () => const MainPage()),
    GetPage(name: AppRoute.login, page: () => const LoginPage()),
    GetPage(name: AppRoute.loginDetail, page: () => const LoginDetailPage()),
    GetPage(name: AppRoute.signup, page: () => const SignupPage()),
    GetPage(name: AppRoute.profile, page: () => const ProfilePage()),
    GetPage(name: AppRoute.permission, page: () => const PermissionPage()),
    GetPage(name: AppRoute.my, page: () => const MyPage()),
    GetPage(name: AppRoute.editProfile, page: () => const EditProfilePage()),
    GetPage(
        name: AppRoute.challengeUpload,
        page: () => const ChallengeUploadPage()),
    GetPage(
        name: AppRoute.keywordSelect, page: () => const KeywordSelectPage()),
    GetPage(
        name: AppRoute.keywordUpdate, page: () => const KeywordUpdatePage()),
    GetPage(name: AppRoute.calendar, page: () => const CalendarPage()),
  ];
}
