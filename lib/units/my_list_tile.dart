import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? timestamp;
  final String? likes;
  const MyListTile({super.key, required this.title, required this.subTitle, this.timestamp, this.likes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15),
        ),

        child: ListTile(
          title: Text(title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subTitle),
              if (timestamp != null) Text('Timestamp: $timestamp'),
              // if (likes != null) Text('Likes: $likes'),
              // TO-DO: like functionality not implemented yet
            ],
          ),
        ),
      ),
    );
  }
}
