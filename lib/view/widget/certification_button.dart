import 'package:flutter/material.dart';

class CertificationButton extends StatelessWidget {
  final String text;

  CertificationButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircleAvatar(
          backgroundColor: Colors.black38,
          radius: 15,
          child: Text(text),
        ),
      ),
    );
  }
}
