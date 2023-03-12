import 'package:firstapp/widgets/storyItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firstapp/data/icons.dart';
import 'package:firstapp/pages/home.dart';

void main() {
  runApp(const MyApp());
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
          fontFamily: 'San Francisco'),
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
  //!1
  int selectedIndex = 1;
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
      body: pages[selectedIndex - 1], //!2
      bottomNavigationBar: Container(
        color: const Color(0x4DF2F2F2),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => {
                setState(() => {selectedIndex = 1})
              },
              icon: selectedIndex == 1 ? homeIconActive : homeIcon,
            ),
            IconButton(
              onPressed: () => {
                setState(() => {selectedIndex = 2})
              },
              icon: selectedIndex == 2 ? searchIconActive : searchIcon,
            ),
            IconButton(
              onPressed: () => {
                setState(() => {selectedIndex = 3})
              },
              icon: selectedIndex == 3 ? addIgtvActive : igtvAdd,
            ),
            IconButton(
              onPressed: () => {
                setState(() => {selectedIndex = 4})
              },
              icon: selectedIndex == 4 ? likesActive : likeIcon,
            ),
            IconButton(
              onPressed: () => {
                setState(() => {selectedIndex = 5})
              },
              icon: const CircleAvatar(
                backgroundImage: AssetImage('images/avatar.jpg'),
                radius: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
