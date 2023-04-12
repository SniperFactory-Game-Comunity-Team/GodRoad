import 'package:flutter/material.dart';
import 'package:godroad/model/challenge.dart';

class ChallengeInformationScreen extends StatelessWidget {
  const ChallengeInformationScreen({super.key, required this.challenge});
  static String route = '/challengeinformation';
  final Challenge challenge;

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
            challenge.content,
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
                  image: DecorationImage(
                      image: NetworkImage(
                    challenge.testimonyPicture != ''
                        ? challenge.testimonyPicture
                        : 'https://picsum.photos/500/200',
                  ))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            challenge.testimonyContent,
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
