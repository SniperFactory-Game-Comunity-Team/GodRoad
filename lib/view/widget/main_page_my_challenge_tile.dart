import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainPageMyChallnegeTile extends StatelessWidget {
  const MainPageMyChallnegeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/150/150'))),
              ),
              Positioned(
                bottom: 10,
                left: 25,
                child: Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black38),
                  child: Center(
                      child: Text(
                    '인증하기(3/10)',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Container(
                width: 150,
                height: 35,
                child: Text(
                  '스나이퍼팩토리에 대한 홍보글 작성 챌린지에 참여해보세요.',
                  style: TextStyle(fontSize: 12),
                )),
          ),
          Text(
            '챌린지가 끝나기까지 D-7',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
