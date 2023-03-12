import 'package:flutter/material.dart';
import 'package:firstapp/widgets/post.dart';

final postsList = [
  Post(
    authorName: 'zackjohn',
    location: 'Tokyo, Japan',
    isOriginalProfile: true,
    imageList: [
      Image.asset('images/tokyo1.jpg',
          fit: BoxFit.cover, width: double.infinity),
      Image.asset('images/tokyo2.jpg',
          fit: BoxFit.cover, width: double.infinity),
      Image.asset('images/tokyo3.jpg',
          fit: BoxFit.cover, width: double.infinity)
    ],
    likedBy: 'craig_love',
    othersLikesNumber: 44686,
    description:
        'The game in Japan was amazing and I want to share some photos',
    likedByAvatarPath: 'images/avatar5.jpg',
    authorAvatarPath: 'images/avatar3.jpg',
  ),
  Post(
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
    authorName: 'karennne',
    location: 'Kyiv, Ukraine',
    isOriginalProfile: true,
    imageList: [
      Image.asset('images/kyiv.jpg', fit: BoxFit.cover, width: double.infinity),
    ],
    likedBy: 'craig_love',
    othersLikesNumber: 145678,
    description: 'My wonderful city',
    likedByAvatarPath: 'images/avatar5.jpg',
    authorAvatarPath: 'images/avatar2.jpg',
  ),
];
