import 'package:flutter/material.dart';
import 'package:firstapp/data/storyData.dart';
import '../../widgets/post.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key, required this.postsList});
  final List<Post> postsList;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Divider(
        color: Colors.grey[300],
        height: 0,
        indent: 0,
        thickness: 1,
      ),
      SizedBox(
        height: 104,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          scrollDirection: Axis.horizontal,
          children: List.generate(storyItems.length, (index) {
            return Row(
              children: [
                storyItems[index],
                if (index != storyItems.length - 1) const SizedBox(width: 20)
              ],
            );
          }),
        ),
      ),
      Divider(
        color: Colors.grey[300],
        height: 0,
        indent: 0,
        thickness: 1,
      ),
      Column(children: postsList)
    ]);
  }
}
