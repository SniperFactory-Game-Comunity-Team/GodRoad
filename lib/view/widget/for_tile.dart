import 'package:flutter/material.dart';
import 'package:godroad/model/challenge.dart';

class ForTile extends StatelessWidget {
  const ForTile({
    super.key,
    required this.challenge,
  });
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Card(
          color: Colors.grey.shade300,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(challenge.mainPicture != ''
                  ? challenge.mainPicture
                  : 'https://picsum.photos/100/100'),
            ),
            title: Text(
              challenge.title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            subtitle: Wrap(
              children: challenge.keyword
                  .map((e) => GestureDetector(
                        onTap: () {},
                        child: Text(
                          e,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ))
                  .toList(),
            ),
            trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                onPressed: () {},
                child: Text('참여하기')),
          )),
    );
  }
}
