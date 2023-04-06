import 'package:flutter/material.dart';

class ForTile extends StatelessWidget {
  const ForTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.keyWord});
  final String imageUrl;
  final String title;
  final String keyWord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Card(
          color: Colors.grey.shade300,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              keyWord,
              style: TextStyle(fontSize: 12),
            ),
            trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                onPressed: () {},
                child: Text('참여하기')),
          )),
    );
  }
}
