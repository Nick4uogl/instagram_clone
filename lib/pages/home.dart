import 'package:firstapp/widgets/storyItem.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/data/postsData.dart';
import 'package:firstapp/pages/chates.dart';
import 'package:firstapp/data/icons.dart';

final List<Widget> storyItems = [
  const StoryItem(author: "Your Story", assetPath: 'images/avatar.jpg'),
  const StoryItem(
      author: "karennne", assetPath: 'images/avatar2.jpg', isTranslating: true),
  const StoryItem(author: "zackjohn", assetPath: 'images/avatar3.jpg'),
  const StoryItem(author: "kieron_d", assetPath: 'images/avatar4.jpg'),
  const StoryItem(author: "craig_love", assetPath: 'images/avatar5.jpg'),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 46,
        titleSpacing: 0,
        toolbarHeight: 44,
        centerTitle: true,
        leading: SizedBox(
          width: 24,
          height: 22,
          child: IconButton(
            icon: cameraIcon,
            onPressed: null,
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            instagramIcon,
          ],
        ),
        backgroundColor: const Color(0x4DF2F2F2),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: null,
            icon: igtvIcon,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Chates()),
              );
            },
            icon: messengerIcon,
          ),
        ],
      ),
      body: ListView(children: [
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
      ]),
    );
  }
}
