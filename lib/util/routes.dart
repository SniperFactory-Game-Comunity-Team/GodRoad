import 'package:godroad/view/page/login_detail_page.dart';
import 'package:godroad/view/page/login_page.dart';
import 'package:godroad/view/page/main_page.dart';
import 'package:godroad/view/page/main_pageview_page.dart';
import 'package:godroad/view/page/permission_page.dart';
import 'package:godroad/view/page/profile_page.dart';
import 'package:godroad/view/page/signup_page.dart';

class AppRoute {
  static final main = MainPage.route;
  static final login = LoginPage.route;
  static final loginDetail = LoginDetailPage.route;
  static final signup = SignupPage.route;
  static final profile = ProfilePage.route;
  static final pageivew = MainPageViewPage.route;
  static final permission = PermissionPage.route;
}
