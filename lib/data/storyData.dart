import 'package:firstapp/widgets/storyItem.dart';
import 'package:flutter/material.dart';

final List<Widget> storyItems = [
  StoryItem(
    author: "Your Story",
    assetPath: 'images/avatar.jpg',
    images: [
      Image.asset(
        'images/tokyo2.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
      ),
      Image.asset('images/tokyo3.jpg',
          fit: BoxFit.cover, width: double.infinity)
    ],
  ),
  StoryItem(
      author: "karennne",
      assetPath: 'images/avatar2.jpg',
      isTranslating: true,
      images: [
        Image.asset('images/tokyo1.jpg',
            fit: BoxFit.cover, width: double.infinity),
      ]),
  StoryItem(author: "zackjohn", assetPath: 'images/avatar3.jpg', images: [
    Image.asset('images/paris1.jpg', fit: BoxFit.cover, width: double.infinity),
    Image.asset('images/paris2.jpg', fit: BoxFit.cover, width: double.infinity),
  ]),
  StoryItem(author: "kieron_d", assetPath: 'images/avatar4.jpg', images: [
    Image.asset('images/tokyo1.jpg', fit: BoxFit.cover, width: double.infinity),
  ]),
  StoryItem(author: "craig_love", assetPath: 'images/avatar5.jpg', images: [
    Image.asset('images/tokyo1.jpg', fit: BoxFit.cover, width: double.infinity),
  ]),
];
