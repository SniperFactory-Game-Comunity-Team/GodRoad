import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Profile {
  String id;
  String? nickname;
  String myClass;
  int experience;
  String email;
  //뱃지
  Profile({
    required this.id,
    this.nickname,
    required this.myClass,
    required this.experience,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nickname': nickname,
      'myClass': myClass,
      'experience': experience,
      'email': email,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as String,
      nickname: map['nickname'] != null ? map['nickname'] as String : null,
      myClass: map['myClass'] as String,
      experience: map['experience'] as int,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source) as Map<String, dynamic>);
}
