import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/post.dart';
import 'addPost/AddPostPopUp.dart';
import 'MyAppBar.dart';
import 'MyDrawer.dart';
import 'HomePageBody.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<Post> postsList = [
    Post(
      id: '1',
      authorName: 'zackjohn',
      location: 'Tokyo, Japan',
      isOriginalProfile: true,
      imageList: [
        Image.asset('images/tokyo1.jpg',
            fit: BoxFit.cover, width: double.infinity),
        Image.asset('images/tokyo2.jpg',
            fit: BoxFit.cover, width: double.infinity),
        Image.asset(
          'images/tokyo3.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
        )
      ],
      likedBy: 'craig_love',
      othersLikesNumber: 44686,
      description:
          'The game in Japan was amazing and I want to share some photos',
      likedByAvatarPath: 'images/avatar5.jpg',
      authorAvatarPath: 'images/avatar3.jpg',
    ),
    Post(
      id: '2',
      authorName: 'kieron_d',
      location: 'Paris, France',
      isOriginalProfile: false,
      imageList: [
        Image.asset('images/paris1.jpg',
            fit: BoxFit.cover, width: double.infinity),
        Image.asset('images/paris2.jpg',
            fit: BoxFit.cover, width: double.infinity),
      ],
      likedBy: 'zackjohn',
      othersLikesNumber: 1,
      likedByAvatarPath: 'images/avatar3.jpg',
      authorAvatarPath: 'images/avatar4.jpg',
    ),
    Post(
      id: '3',
      authorName: 'karennne',
      location: 'Kyiv, Ukraine',
      isOriginalProfile: true,
      imageList: [
        Image.asset(
          'images/kyiv.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ],
      likedBy: 'craig_love',
      othersLikesNumber: 145678,
      description: 'My wonderful city',
      likedByAvatarPath: 'images/avatar5.jpg',
      authorAvatarPath: 'images/avatar2.jpg',
    ),
  ];

  void changePosts(Post post) {
    setState(() {
      postsList = [post, ...postsList];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: MyAppBar(
        globalKey: _key,
      ),
      drawer: const MyDrawer(),
      body: HomePageBody(
        postsList: postsList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddPostPopUp(
              changePosts: changePosts,
            ),
          );
        },
        backgroundColor: const Color(0xffF2F2F2),
        elevation: 20,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
