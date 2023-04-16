import 'package:flutter/cupertino.dart';

class StoryModel {
  final List<Widget> images;
  final String author;
  final Function changeIsViewed;
  const StoryModel({
    required this.images,
    required this.author,
    required this.changeIsViewed,
  });
}
