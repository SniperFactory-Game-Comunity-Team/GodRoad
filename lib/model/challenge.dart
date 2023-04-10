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
  List participationUserId;
  int authenticationCount;
  int bookmark;
  DateTime createAt;
  DateTime applyStartDay;
  DateTime applyEndDay;
  DateTime? startDay;
  DateTime? endDay;

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
    required this.participationUserId,
    required this.authenticationCount,
    required this.bookmark,
    required this.createAt,
    required this.applyStartDay,
    required this.applyEndDay,
    this.startDay,
    this.endDay,
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
      'bookmark': bookmark,
      'createAt': createAt.millisecondsSinceEpoch,
      'applyStartDay': applyStartDay.millisecondsSinceEpoch,
      'applyEndDay': applyEndDay.millisecondsSinceEpoch,
      'startDay': startDay?.millisecondsSinceEpoch,
      'endDay': endDay?.millisecondsSinceEpoch,
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
      keyword: List.from((map['keyword'] as List)),
      participationUserId: List.from((map['participationUserId'] as List)),
      bookmark: map['bookmark'] as int,
      authenticationCount: map['authenticationCount'] as int,
      createAt: DateTime.fromMillisecondsSinceEpoch(
          map['createAt'].microsecondsSinceEpoch),
      applyStartDay: DateTime.fromMillisecondsSinceEpoch(
          map['applyStartDay'].microsecondsSinceEpoch),
      applyEndDay: DateTime.fromMillisecondsSinceEpoch(
          map['applyEndDay'].microsecondsSinceEpoch),
      startDay: map['startDay'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['startDay'].microsecondsSinceEpoch)
          : null,
      endDay: map['endDay'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['endDay'].microsecondsSinceEpoch)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Challenge.fromJson(String source) =>
      Challenge.fromMap(json.decode(source) as Map<String, dynamic>);
}
