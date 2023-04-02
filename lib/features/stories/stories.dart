import 'package:flutter/material.dart';
import 'package:firstapp/core/data/story_data.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }
}
