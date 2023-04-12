import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/model/profile.dart';

class Firebase {
  static var colUser = FirebaseFirestore.instance.collection('user');
  static var colChall = FirebaseFirestore.instance.collection('challenge');
  static var getUser = colUser.withConverter(
    fromFirestore: (snapshot, _) => Profile.fromMap(snapshot.data()!),
    toFirestore: (data, _) => data.toMap(),
  );
  static var getChallenge = colChall.withConverter(
    fromFirestore: (snapshot, _) => Challenge.fromMap(snapshot.data()!),
    toFirestore: (data, _) => data.toMap(),
  );
}
