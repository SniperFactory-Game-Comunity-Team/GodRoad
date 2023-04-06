import 'package:get/get.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/page/login_detail_page.dart';
import 'package:godroad/view/page/login_page.dart';
import 'package:godroad/view/page/main_page.dart';
import 'package:godroad/view/page/main_pageview_page.dart';
import 'package:godroad/view/page/permission_page.dart';
import 'package:godroad/view/page/profile_page.dart';
import 'package:godroad/view/page/signup_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoute.main, page: () => const MainPage()),
    GetPage(name: AppRoute.login, page: () => const LoginPage()),
    GetPage(name: AppRoute.loginDetail, page: () => const LoginDetailPage()),
    GetPage(name: AppRoute.signup, page: () => const SignupPage()),
    GetPage(name: AppRoute.profile, page: () => const ProfilePage()),
    GetPage(name: AppRoute.pageivew, page: () => const MainPageViewPage()),
    GetPage(name: AppRoute.permission, page: () => const PermissionPage())
  ];
}
