import 'package:firstapp/core/theme/bloc/theme_bloc.dart';
import 'package:firstapp/core/theme/theme_model.dart';
import 'package:firstapp/features/feed/bloc/image_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firstapp/features/feed/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLightTheme = prefs.getBool('isLightTheme') ?? true;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ImagePickerBlock>(
          create: (_) => ImagePickerBlock(),
        ),
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(isLightTheme),
        ),
      ],
      child: const InstagramApp(),
    ),
  );
}

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Instagram',
          theme:
              state.isLightTheme ? ThemeModel.lightTheme : ThemeModel.darkTheme,
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(),
        );
      },
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
      color: Theme.of(context).primaryColor,
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
            icon: selectedIndex == 0
                ? SvgPicture.asset(
                    'images/homeActive.svg',
                    color: Theme.of(context).iconTheme.color,
                  )
                : SvgPicture.asset(
                    'images/home.svg',
                    color: Theme.of(context).iconTheme.color,
                  ),
          ),
          IconButton(
            onPressed: () => {
              controller.animateToPage(1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease)
            },
            icon: selectedIndex == 1
                ? SvgPicture.asset(
                    'images/searchActive.svg',
                    color: Theme.of(context).iconTheme.color,
                  )
                : SvgPicture.asset(
                    'images/search.svg',
                    color: Theme.of(context).iconTheme.color,
                  ),
          ),
          IconButton(
            onPressed: () => {
              controller.animateToPage(2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease)
            },
            icon: selectedIndex == 2
                ? SvgPicture.asset(
                    'images/addIgtvActive.svg',
                    color: Theme.of(context).iconTheme.color,
                  )
                : SvgPicture.asset(
                    'images/addIgtv.svg',
                    color: Theme.of(context).iconTheme.color,
                  ),
          ),
          IconButton(
            onPressed: () => {
              controller.animateToPage(3,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease)
            },
            icon: selectedIndex == 3
                ? SvgPicture.asset(
                    'images/likesActive.svg',
                    color: Theme.of(context).iconTheme.color,
                  )
                : SvgPicture.asset(
                    'images/likes.svg',
                    color: Theme.of(context).iconTheme.color,
                  ),
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
