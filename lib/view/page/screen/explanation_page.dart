import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/view/page/login_page.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Map<String, dynamic>> _pages = [
    {
      'title': '첫번째 페이지',
      'description': '첫번째 페이지 설명입니다',
    },
    {
      'title': '두번째 페이지',
      'description': '두번째 페이지 설명입니다',
    },
    {
      'title': '세번째 페이지',
      'description': '로그인 하세요!',
    },
  ];
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400,
          width: 300,
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
      floatingActionButton: _currentPageIndex == _pages.length - 1
          ? ElevatedButton(
              child: Text('로그인하기'),
              onPressed: () {
                Get.to(LoginPage());
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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
          SizedBox(height: 16.0),
          Text(
            pageData['description'],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 32.0),
        ],
      ),
    );
  }
}
