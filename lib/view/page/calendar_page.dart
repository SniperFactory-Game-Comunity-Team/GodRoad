import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/controller/calendar_controller.dart';
import 'package:godroad/view/widget/calendar.dart';

class CalendarPage extends GetView<CalendarController> {
  const CalendarPage({super.key});
  static String route = '/calendar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          title: const Text('신청 및 챌린지 기간 설정')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '신청 기간 설정',
                  style: TextStyle(fontSize: 20),
                ),
                Calendar(
                    datenow: controller.datenow,
                    startDay: controller.applyStartDay,
                    endDay: controller.applyEndDay,
                    focusedDay: controller.applyFocusedDay),
                const Text(
                  '챌린지 기간 설정',
                  style: TextStyle(fontSize: 20),
                ),
                Calendar(
                  datenow: controller.datenow,
                  startDay: controller.challStartDay,
                  endDay: controller.challEndDay,
                  focusedDay: controller.challFocusedDay,
                )
              ],
            )),
      )),
    );
  }
}
