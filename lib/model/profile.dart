import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Profile {
  String id;
  String? nickname;
  String email;
  String? profileUrl;
  List myBookmark;
  List myChallenge;
  List keyword;
  Profile({
    required this.id,
    this.nickname,
    required this.email,
    this.profileUrl,
    required this.myBookmark,
    required this.myChallenge,
    required this.keyword,
  });
  //createAt


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nickname': nickname,
      'email': email,
      'profileUrl': profileUrl,
      'myBookmark': myBookmark,
      'myChallenge': myChallenge,
      'keyword': keyword,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as String,
      nickname: map['nickname'] != null ? map['nickname'] as String : null,
      email: map['email'] as String,
      profileUrl: map['profileUrl'] != null ? map['profileUrl'] as String : null,
      myBookmark: List.from((map['myBookmark'] as List)),
      myChallenge: List.from((map['myChallenge'] as List)),
      keyword: List.from((map['keyword'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source) as Map<String, dynamic>);
}
