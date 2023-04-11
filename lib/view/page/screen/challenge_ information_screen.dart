import 'package:flutter/material.dart';

class ChallengeInformationScreen extends StatelessWidget {
  const ChallengeInformationScreen({super.key});
  static String route = '/challengeinformation';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "활동소개",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '활동설명\n활동설명\n활동설명',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "인증방법",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 500,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text('인증샷예시'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '인증방법\n인증방법\n인증방법',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
