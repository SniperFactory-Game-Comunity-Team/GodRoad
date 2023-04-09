import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:godroad/view/widget/certification_button.dart';

class ChallengeCertificationScreen extends StatefulWidget {
  const ChallengeCertificationScreen({super.key});

  @override
  State<ChallengeCertificationScreen> createState() =>
      _ChallengeCertificationScreenState();
}

class _ChallengeCertificationScreenState
    extends State<ChallengeCertificationScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Map<String, dynamic>> _pages = [
    {
      'title': '1번 인증',
    },
    {
      'title': '2번 인증',
    },
    {
      'title': '3번 인증',
    },
  ];
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "인증기록",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CertificationButton(
                  text: "1",
                ),
                CertificationButton(
                  text: "2",
                ),
                CertificationButton(
                  text: "3",
                ),
                CertificationButton(
                  text: "4",
                ),
                CertificationButton(
                  text: "5",
                ),
                CertificationButton(
                  text: "6",
                ),
                CertificationButton(
                  text: "7",
                ),
                CertificationButton(
                  text: "8",
                ),
                CertificationButton(
                  text: "9",
                ),
                CertificationButton(
                  text: "10",
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "오늘의 인증",
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
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
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
            Text(
              "팀원 인증 기록",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CertificationButton(
                  text: "1",
                ),
                CertificationButton(
                  text: "2",
                ),
                CertificationButton(
                  text: "3",
                ),
                CertificationButton(
                  text: "4",
                ),
                CertificationButton(
                  text: "5",
                ),
                CertificationButton(
                  text: "6",
                ),
                CertificationButton(
                  text: "7",
                ),
                CertificationButton(
                  text: "8",
                ),
                CertificationButton(
                  text: "9",
                ),
                CertificationButton(
                  text: "10",
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("인증하기"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPage(Map<String, dynamic> pageData) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          pageData['title'],
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
