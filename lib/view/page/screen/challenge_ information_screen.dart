import 'package:flutter/material.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/util/my_color.dart';

class ChallengeInformationScreen extends StatelessWidget {
  const ChallengeInformationScreen({super.key, required this.challenge});
  static String route = '/challengeinformation';
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "활동소개",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                challenge.content,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              
        
            ],
          ),
        ),
        const Divider(thickness: 6,color: MyColor.lightgrey,),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  const Text(
                  "인증방법",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        color: MyColor.lightgrey,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                          challenge.testimonyPicture != ''
                              ? challenge.testimonyPicture
                              : 'https://picsum.photos/500/200',
                        ))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    challenge.testimonyContent,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
        
          ],),
        )
      ],
    );
  }
}
