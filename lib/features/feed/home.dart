import 'package:firstapp/features/feed/repositories/posts_repository.dart';
import 'package:flutter/material.dart';
import 'widgets/post.dart';
import 'widgets/add_post_popup.dart';
import 'widgets/my_app_bar.dart';
import 'widgets/my_drawer.dart';
import 'widgets/home_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final PostsRepository postsRepository = PostsRepository();
  //late Future<List<PostModel>> fetchedPosts;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchedPosts = postsRepository.getPosts();
  // }

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
      // FutureBuilder(
      //   future: fetchedPosts,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       var list = List.generate(
      //           snapshot.data!.length,
      //           (index) => Post(
      //                 id: "$index",
      //                 authorName: snapshot.data![index].authorName,
      //                 location: snapshot.data![index].location,
      //                 isOriginalProfile: false,
      //                 imageList: [
      //                   Image.network(
      //                     snapshot.data![index].img,
      //                     fit: BoxFit.cover,
      //                     width: double.infinity,
      //                   )
      //                 ],
      //                 likedBy: snapshot.data![index].likedBy,
      //                 othersLikesNumber: 1,
      //                 likedByAvatarPath: 'images/avatar3.jpg',
      //                 authorAvatarPath: 'images/avatar4.jpg',
      //               ));
      //       return HomePageBody(
      //         postsList: list,
      //       );
      //     } else if (snapshot.hasError) {
      //       return Text('${snapshot.error}');
      //     }
      //
      //     // By default, show a loading spinner.
      //     return const Center(child: CircularProgressIndicator());
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddPostPopUp(
              changePosts: changePosts,
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 20,
        child: Icon(
          Icons.add,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
