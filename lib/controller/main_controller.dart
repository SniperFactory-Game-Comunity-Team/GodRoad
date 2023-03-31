import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/auth_controller.dart';
import 'package:godroad/model/profile.dart';

class MainController extends GetxController {
  var auth = Get.find<AuthController>();
  readProfile() async {
    var profileData = await FirebaseFirestore.instance
        .collection('user')
        .doc(auth.user!.uid)
        .withConverter(
          fromFirestore: (snapshot, _) => Profile.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toMap(),
        )
        .get();
    if (profileData.data() != null) {
      print('닉네임:${profileData.data()!.nickname}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    readProfile();
  }
}
