import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:godroad/util/my_color.dart';

class KeywordChip extends StatelessWidget {
  const KeywordChip(
      {super.key,
      required this.keyword,
      required this.onTap,
      required this.isSelected});
  final List keyword;
  final Function onTap;
  final RxMap isSelected;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: keyword
          .map((e) => GestureDetector(
                onTap: () {
                  onTap(e);
                },
                child: Obx(
                  () => Chip(
                    backgroundColor: isSelected[e] == null
                        ? MyColor.color200
                        : isSelected[e]
                            ? MyColor.primary2
                            : MyColor.color200,
                    label: SizedBox(
                      width: 60,
                      child: Center(
                        child: Text(
                          e,
                          style: TextStyle(
                            color: isSelected[e] == null
                                ? MyColor.primary2
                                : isSelected[e]
                                    ? Colors.white
                                    : MyColor.primary2,
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
