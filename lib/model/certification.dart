import 'dart:convert';

class Certification {
  String id;
  int cerCount;
  String cerImg;
  String cerContent;
  String challengeId;
  Certification({
    required this.id,
    required this.cerCount,
    required this.cerImg,
    required this.cerContent,
    required this.challengeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cerCount': cerCount,
      'cerImg': cerImg,
      'cerContent': cerContent,
      'challengeId': challengeId,
    };
  }

  factory Certification.fromMap(Map<String, dynamic> map) {
    return Certification(
      id: map['id'] as String,
      cerCount: map['cerCount'] as int,
      cerImg: map['cerImg'] as String,
      cerContent: map['cerContent'] as String,
      challengeId: map['challengeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Certification.fromJson(String source) =>
      Certification.fromMap(json.decode(source) as Map<String, dynamic>);
}
