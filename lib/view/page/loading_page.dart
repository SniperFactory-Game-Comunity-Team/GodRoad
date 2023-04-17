import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../util/my_color.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});
  static String route = '/loading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              width: 60,
              height: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            const SpinKitFadingCircle(
              color: MyColor.primary,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
