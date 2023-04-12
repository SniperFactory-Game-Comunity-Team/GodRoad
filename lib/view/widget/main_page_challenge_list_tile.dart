import 'package:flutter/material.dart';
import 'package:godroad/model/challenge.dart';
import 'package:godroad/view/widget/custom_button.dart';

class MainPageChallengeListTile extends StatelessWidget {
  const MainPageChallengeListTile(
      {super.key, required this.buttontext, required this.challenge});
  final String buttontext;
  final Challenge challenge;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            Image(
                image: NetworkImage(challenge.mainPicture != ''
                    ? challenge.mainPicture
                    : 'https://picsum.photos/100/100')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        challenge.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.bookmark,
                            color: Colors.grey,
                          ),
                          Text(challenge.bookmark.toString()),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '챌린지 마감 D-${challenge.endDay.day - DateTime.now().day}',
                            style: const TextStyle(color: Colors.greenAccent),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        '총 인증 수 ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text('15 '),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '남은 인증 수 ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text('4')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        children: challenge.keyword
                            .map((e) => GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    e,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ))
                            .toList(),
                      ),
                      CustomButton(
                          text: buttontext,
                          onPressedFunction: () {},
                          isEnabled: true)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
