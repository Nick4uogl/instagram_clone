import 'package:flutter/material.dart';
import '../../stories/stories.dart';
import 'post.dart';

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
      const SizedBox(
        height: 104,
        child: Stories(),
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
