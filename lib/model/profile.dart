import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Profile {
  String id;
  String? nickname;
  String email;
  String? profileUrl;
  //createAt
  Profile({
    required this.id,
    this.nickname,
    required this.email,
    this.profileUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nickname': nickname,
      'email': email,
      'profileUrl': profileUrl,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as String,
      nickname: map['nickname'] != null ? map['nickname'] as String : null,
      email: map['email'] as String,
      profileUrl: map['profileUrl'] != null ? map['profileUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source) as Map<String, dynamic>);
}
