import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/util/my_color.dart';

class KeywordChip extends StatelessWidget {
  const KeywordChip(
      {super.key,
      required this.keyword,
      required this.onTap,
      required this.isSelected,
      required this.unSelectedBackgroundColor,
      required this.unSelectedTextColor});
  final List keyword;
  final Function onTap;
  final RxMap isSelected;
  final Color unSelectedBackgroundColor;
  final Color unSelectedTextColor;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7,
      children: keyword
          .map((e) => GestureDetector(
                onTap: () {
                  onTap(e);
                },
                child: Obx(
                  () => Chip(
                    backgroundColor: isSelected[e] == null
                        ? unSelectedBackgroundColor
                        : isSelected[e]
                            ? MyColor.primary2
                            : unSelectedBackgroundColor,
                    label: SizedBox(
                      width: 60,
                      child: Center(
                        child: Text(
                          e,
                          style: TextStyle(
                            color: isSelected[e] == null
                                ? unSelectedTextColor
                                : isSelected[e]
                                    ? Colors.white
                                    : unSelectedTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
