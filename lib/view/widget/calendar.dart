import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar(
      {super.key,
      required this.datenow,
      required this.startDay,
      required this.endDay,
      required this.focusedDay});
  final Rx<DateTime> datenow;
  final Rx<DateTime> startDay;
  final Rx<DateTime> endDay;
  final Rx<DateTime> focusedDay;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TableCalendar(
        firstDay: DateTime.utc(datenow.value.year, datenow.value.month, 1),
        lastDay:
            DateTime.utc(datenow.value.year + 10, datenow.value.month + 1, 14),
        focusedDay: focusedDay.value,
        selectedDayPredicate: (DateTime day) {
          return isSameDay(startDay.value, day);
        },
        rangeStartDay: startDay.value,
        rangeEndDay: focusedDay.value,
        onRangeSelected: (start, end, focusedDay) {
          startDay(start);
          endDay(end);
          this.focusedDay(focusedDay);
        },
        rangeSelectionMode: RangeSelectionMode.enforced,
      ),
    );
  }
}
