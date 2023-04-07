import 'package:flutter/material.dart';
import 'package:godroad/model/challenge.dart';

class RealTimeTile extends StatelessWidget {
  const RealTimeTile({
    super.key,
    required this.challenge,
  });
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              child: Image(
                image: NetworkImage(challenge.mainPicture != ''
                    ? challenge.mainPicture
                    : 'https://picsum/photos/100/100'),
                width: 100,
                height: 100,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          challenge.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 45,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(16)),
                          child: const Text(
                            'D-15',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      challenge.content,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Wrap(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.people,
                          size: 15,
                        ),
                        Text(
                          '0/4',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.star,
                          size: 15,
                        ),
                        Text('123')
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
