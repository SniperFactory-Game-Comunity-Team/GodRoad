// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Certification {
  String id;
  String challengeId;
  String userId;
  int count;
  String img;
  String content;
  DateTime createAt;
  Certification({
    required this.id,
    required this.challengeId,
    required this.userId,
    required this.count,
    required this.img,
    required this.content,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'challengeId': challengeId,
      'userId': userId,
      'count': count,
      'img': img,
      'content': content,
      'createAt': createAt,
    };
  }

  factory Certification.fromMap(Map<String, dynamic> map) {
    return Certification(
      id: map['id'] as String,
      challengeId: map['challengeId'] as String,
      userId: map['userId'] as String,
      count: map['count'] as int,
      img: map['img'] as String,
      content: map['content'] as String,
      createAt: DateTime.fromMicrosecondsSinceEpoch(
          map['createAt'].microsecondsSinceEpoch),
    );
  }

  String toJson() => json.encode(toMap());

  factory Certification.fromJson(String source) =>
      Certification.fromMap(json.decode(source) as Map<String, dynamic>);
}
