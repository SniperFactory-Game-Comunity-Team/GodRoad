import 'package:get/get.dart';
import 'package:godroad/util/routes.dart';
import 'package:godroad/view/page/attending_challenge_detail_page.dart';
import 'package:godroad/view/page/bookmark_page.dart';
import 'package:godroad/view/page/challenge_detail_page.dart';
import 'package:godroad/view/page/challenge_upload_page.dart';
import 'package:godroad/view/page/created_challenge_page.dart';
import 'package:godroad/view/page/explanation_page.dart';
import 'package:godroad/view/page/keyword_select_page.dart';
import 'package:godroad/view/page/keyword_update_page.dart';
import 'package:godroad/view/page/attending_challenge_page.dart';
import 'package:godroad/view/page/end_challenge_page.dart';
import 'package:godroad/view/page/loading_page.dart';
import 'package:godroad/view/page/login_detail_page.dart';
import 'package:godroad/view/page/main_page.dart';
import 'package:godroad/view/page/permission_page.dart';
import 'package:godroad/view/page/edit_profile_page.dart';
import 'package:godroad/view/page/my_page.dart';
import 'package:godroad/view/page/profile_page.dart';
import 'package:godroad/view/page/real_tile_challenge_list_page.dart';
import 'package:godroad/view/page/search_challenge_page.dart';
import 'package:godroad/view/page/signup_complete_page.dart';
import 'package:godroad/view/page/signup_page.dart';
import 'package:godroad/view/page/update_challenge_detail_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoute.main, page: () => const MainPage()),
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
    GetPage(
        name: AppRoute.attending, page: () => const AttendingChallengePage()),
    GetPage(name: AppRoute.endchallenge, page: () => const EndChallengePage()),
    GetPage(
        name: AppRoute.realtimechallengelist,
        page: () => const RealTimeChallengeListPage()),
    GetPage(
        name: AppRoute.challengedetail,
        page: () => const ChallengeDetailPage()),
    GetPage(
        name: AppRoute.searchChallenge,
        page: () => const SearchChallengePage()),
    GetPage(
        name: AppRoute.createdChallenge,
        page: () => const CreatedChallengePage()),
    GetPage(
        name: AppRoute.attendchallengedetail,
        page: () => const AttendingChallengeDetailPage()),
    GetPage(name: AppRoute.bookmark, page: () => const BookmarkPage()),
    GetPage(name: AppRoute.explanation, page: () => const ExplanationPage()),
    GetPage(
        name: AppRoute.updateChallengeDetail,
        page: () => const UpdateChallengeDetailPage()),
    GetPage(
        name: AppRoute.signupComplete, page: () => const SignUpCompletePage()),
    GetPage(name: AppRoute.loading, page: () => const LoadingPage())
  ];
}
