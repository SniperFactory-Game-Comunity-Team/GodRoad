import 'package:get/get.dart';

class CalendarController extends GetxController {
  Rx<DateTime> datenow = DateTime.now().obs;
  Rx<DateTime> applyStartDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;
  Rx<DateTime> applyEndDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;
  Rx<DateTime> applyFocusedDay = DateTime.now().obs;

  Rx<DateTime> challStartDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;
  Rx<DateTime> challEndDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;
  Rx<DateTime> challFocusedDay = DateTime.now().obs;
}
