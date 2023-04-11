import 'package:flutter/material.dart';

class MyChallengeDetailPage extends StatelessWidget {
  const MyChallengeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.network(
                "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzAzMTJfMTk4%2FMDAxNjc4NTk1NzI0MjUx.PPX5LDRE8gOfTuO0THAeE2kQK0i6srapXKXE9QSHZ-og.nS2yJ13pyBfXX2j4OGmIYLgmH0motDoPrVtz34dv6swg.JPEG.arsonne%2F20190526_105935.jpg&type=sc960_832",
              ), //임의로 사진 넣음
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "챌린지 제목",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "챌린지 부제목",
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "2023.04.01 ~ 2023.06.21",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "D-14",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "OO음악사",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "2023.04.01 20:23",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
