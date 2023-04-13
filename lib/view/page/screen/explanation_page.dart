import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:godroad/view/page/login_page.dart';

class ExplanationPage extends StatefulWidget {
  @override
  _ExplanationPageState createState() => _ExplanationPageState();
}

class _ExplanationPageState extends State<ExplanationPage> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'assets/explanation_1.svg',
    },
    {
      'image': 'assets/explanation_2.svg',
    },
    {
      'image': 'assets/explanation_3.svg',
    },
  ];
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 600,
          width: 400,
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
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(300, 30)),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
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
          SvgPicture.asset(
            pageData['image'],
          ),
        ],
      ),
    );
  }
}
