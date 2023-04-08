import 'package:flutter/material.dart';
import 'package:godroad/view/widget/custom_button.dart';

class MainPageChallengeListTile extends StatelessWidget {
  const MainPageChallengeListTile({super.key, required this.buttontext});
  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            Image(image: NetworkImage('https://picsum.photos/100/100')),
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
                        '대학생 서포터즈 모집',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.bookmark,
                            color: Colors.grey,
                          ),
                          Text('12'),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'D-12',
                            style: TextStyle(color: Colors.greenAccent),
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
                      Row(
                        children: const [
                          Chip(
                              label: Text(
                            '#음악',
                            style: TextStyle(fontSize: 8),
                          )),
                          Chip(
                              label: Text(
                            '#취미',
                            style: TextStyle(fontSize: 8),
                          )),
                          Chip(
                              label: Text(
                            '#모집완료',
                            style: TextStyle(fontSize: 8),
                          )),
                        ],
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
