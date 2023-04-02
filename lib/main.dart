import 'package:firstapp/features/feed/bloc/image_picker_bloc.dart';
import 'package:firstapp/features/feed/models/pick_image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firstapp/core/data/icons.dart';
import 'package:firstapp/features/feed/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => PickImageModel(),
    //   child: const MyApp(),
    // ),
    BlocProvider(
      create: (_) => ImagePickerBlock(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Instagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'San Francisco',
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final PageController controller = PageController();

  final pages = [
    const HomePage(),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Add Post'),
    ),
    const Center(
      child: Text('Likes'),
    ),
    const Center(
      child: Text('Profile'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavBar(
        controller: controller,
        selectedIndex: selectedIndex,
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {super.key, required this.controller, required this.selectedIndex});
  final int selectedIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0x4DF2F2F2),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => {
              controller.animateToPage(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease)
            },
            icon: selectedIndex == 0 ? homeIconActive : homeIcon,
          ),
          IconButton(
            onPressed: () => {
              controller.animateToPage(1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease)
            },
            icon: selectedIndex == 1 ? searchIconActive : searchIcon,
          ),
          IconButton(
            onPressed: () => {
              controller.animateToPage(2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease)
            },
            icon: selectedIndex == 2 ? addIgtvActive : igtvAdd,
          ),
          IconButton(
            onPressed: () => {
              controller.animateToPage(3,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease)
            },
            icon: selectedIndex == 3 ? likesActive : likeIcon,
          ),
          IconButton(
            onPressed: () => {
              controller.animateToPage(4,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease)
            },
            icon: const CircleAvatar(
              backgroundImage: AssetImage('images/avatar.jpg'),
              radius: 13,
            ),
          ),
        ],
      ),
    );
  }
}
