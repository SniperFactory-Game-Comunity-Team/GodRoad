import 'package:flutter/material.dart';
import 'package:godroad/view/widget/for_tile.dart';
import 'package:godroad/view/widget/real_time_tile.dart';

class OutsideActivityPage extends StatelessWidget {
  const OutsideActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '실시간 인기 대외 활동',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('모두보기'),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                shrinkWrap: true,
                children: const [
                  RealTimeTile(
                      imgUrl: 'https://picsum.photos/100/100',
                      title: '대학생 서포터즈 모집',
                      content: '함께 좋은 경험 만들어요!',
                      date: 'D-15',
                      keyword: '#음악 #모집중',
                      favorite: 123,
                      memberNum: '0/4'),
                  RealTimeTile(
                      imgUrl: 'https://picsum.photos/100/100',
                      title: '대학생 서포터즈 모집',
                      content: '함께 좋은 경험 만들어요!',
                      date: 'D-15',
                      keyword: '#음악 #모집중',
                      favorite: 123,
                      memberNum: '0/4'),
                  RealTimeTile(
                      imgUrl: 'https://picsum.photos/100/100',
                      title: '대학생 서포터즈 모집',
                      content: '함께 좋은 경험 만들어요!',
                      date: 'D-15',
                      keyword: '#음악 #모집중',
                      favorite: 123,
                      memberNum: '0/4')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'OO님을 위한 대외 활동',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('모두보기'),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                children: const [
                  ForTile(
                      imageUrl: 'https://picsum.photos/100/100',
                      title: '바이올린 체르니 도전!',
                      keyWord: '#음악 #모집중'),
                  ForTile(
                      imageUrl: 'https://picsum.photos/100/100',
                      title: '바이올린 체르니 도전!',
                      keyWord: '#음악 #모집중'),
                  ForTile(
                      imageUrl: 'https://picsum.photos/100/100',
                      title: '바이올린 체르니 도전!',
                      keyWord: '#음악 #모집중')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '키워드로 모아보기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
