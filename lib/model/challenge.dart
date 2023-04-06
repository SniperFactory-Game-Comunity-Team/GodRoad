import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Challenge {
  String id;
  String userId;
  String title;
  String subtitle;
  String content;
  String mainPicture;
  String testimonyPicture;
  String testimonyContent;
  List keyword;
  //DateTime createAt
  //DateTime startDay;
  //DateTime dDay;

  Challenge({
    required this.id,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.mainPicture,
    required this.testimonyPicture,
    required this.testimonyContent,
    required this.keyword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'mainPicture': mainPicture,
      'testimonyPicture': testimonyPicture,
      'testimonyContent': testimonyContent,
      'keyword': keyword,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
        id: map['id'] as String,
        userId: map['userId'] as String,
        title: map['title'] as String,
        subtitle: map['subtitle'] as String,
        content: map['content'] as String,
        mainPicture: map['mainPicture'] as String,
        testimonyPicture: map['testimonyPicture'] as String,
        testimonyContent: map['testimonyContent'] as String,
        keyword: List.from(
          (map['keyword'] as List),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Challenge.fromJson(String source) =>
      Challenge.fromMap(json.decode(source) as Map<String, dynamic>);
}
