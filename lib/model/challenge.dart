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
  List bookmarkUserId;
  List successUserId;
  bool isApplyEnd;
  bool isEnd;
  int authenticationCount;
  int bookmark;
  DateTime createAt;
  DateTime applyStartDay;
  DateTime applyEndDay;
  DateTime startDay;
  DateTime endDay;

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
    required this.bookmarkUserId,
    required this.successUserId,
    required this.isApplyEnd,
    required this.isEnd,
    required this.authenticationCount,
    required this.bookmark,
    required this.createAt,
    required this.applyStartDay,
    required this.applyEndDay,
    required this.startDay,
    required this.endDay,
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
      'participationUserId': participationUserId,
      'bookmarkUserId': bookmarkUserId,
      'successUserId': successUserId,
      'isApplyEnd': isApplyEnd,
      'isEnd': isEnd,
      'authenticationCount': authenticationCount,
      'bookmark': bookmark,
      'createAt': createAt,
      'applyStartDay': applyStartDay,
      'applyEndDay': applyEndDay,
      'startDay': startDay,
      'endDay': endDay,
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
      bookmarkUserId: List.from((map['bookmarkUserId'] as List)),
      successUserId: List.from((map['successUserId'] as List)),
      isApplyEnd: map['isApplyEnd'] as bool,
      isEnd: map['isEnd'] as bool,
      authenticationCount: map['authenticationCount'] as int,
      bookmark: map['bookmark'] as int,
      createAt: DateTime.fromMicrosecondsSinceEpoch(
          map['createAt'].microsecondsSinceEpoch),
      applyStartDay: DateTime.fromMicrosecondsSinceEpoch(
          map['applyStartDay'].microsecondsSinceEpoch),
      applyEndDay: DateTime.fromMicrosecondsSinceEpoch(
          map['applyEndDay'].microsecondsSinceEpoch),
      startDay: DateTime.fromMicrosecondsSinceEpoch(
          map['startDay'].microsecondsSinceEpoch),
      endDay: DateTime.fromMicrosecondsSinceEpoch(
          map['endDay'].microsecondsSinceEpoch),
    );
  }

  String toJson() => json.encode(toMap());

  factory Challenge.fromJson(String source) =>
      Challenge.fromMap(json.decode(source) as Map<String, dynamic>);
}
