import 'package:godroad/view/page/calendar_page.dart';
import 'package:godroad/view/page/challenge_detail_page.dart';
import 'package:godroad/view/page/challenge_upload_page.dart';
import 'package:godroad/view/page/created_challenge_page.dart';
import 'package:godroad/view/page/keyword_select_page.dart';
import 'package:godroad/view/page/keyword_update_page.dart';
import 'package:godroad/view/page/attending_challenge_page.dart';
import 'package:godroad/view/page/end_challenge_page.dart';
import 'package:godroad/view/page/login_detail_page.dart';
import 'package:godroad/view/page/login_page.dart';
import 'package:godroad/view/page/main_page.dart';
import 'package:godroad/view/page/permission_page.dart';
import 'package:godroad/view/page/edit_profile_page.dart';
import 'package:godroad/view/page/my_page.dart';
import 'package:godroad/view/page/profile_page.dart';
import 'package:godroad/view/page/real_tile_challenge_list_page.dart';
import 'package:godroad/view/page/search_challenge_page.dart';
import 'package:godroad/view/page/signup_page.dart';

class AppRoute {
  static final main = MainPage.route;
  static final login = LoginPage.route;
  static final loginDetail = LoginDetailPage.route;
  static final signup = SignupPage.route;
  static final profile = ProfilePage.route;
  static final permission = PermissionPage.route;
  static final my = MyPage.route;
  static final editProfile = EditProfilePage.route;
  static final challengeUpload = ChallengeUploadPage.route;
  static final keywordSelect = KeywordSelectPage.route;
  static final keywordUpdate = KeywordUpdatePage.route;
  static final calendar = CalendarPage.route;
  static final attending = AttendingChallengePage.route;
  static final endchallenge = EndChallengePage.route;
  static final realtimechallengelist = RealTimeChallengeListPage.route;
  static final challengedetail = ChallengeDetailPage.route;
  static final searchChallenge = SearchChallengePage.route;
  static final createdChallenge = CreatedChallengePage.route;

}
