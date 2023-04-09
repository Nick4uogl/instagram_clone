import 'package:firstapp/core/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../stories/stories.dart';
import 'post.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key, required this.postsList});
  final List<Post> postsList;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Divider(
        color: Theme.of(context).dividerColor,
        height: 0,
        indent: 0,
        thickness: 1,
      ),
      const SizedBox(
        height: 104,
        child: Stories(),
      ),
      Divider(
        color: Theme.of(context).dividerColor,
        height: 0,
        indent: 0,
        thickness: 1,
      ),
      Column(children: postsList)
    ]);
  }
}
