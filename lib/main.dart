import 'package:firstapp/core/theme/bloc/theme_bloc.dart';
import 'package:firstapp/core/theme/theme_model.dart';
import 'package:firstapp/features/chats/chates.dart';
import 'package:firstapp/features/feed/bloc/image_picker_bloc.dart';
import 'package:firstapp/features/stories/widgets/story_item.dart';
import 'package:firstapp/features/user/user_screen.dart';
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
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          initialRoute: '/',
          title: 'Instagram',
          theme:
              state.isLightTheme ? ThemeModel.lightTheme : ThemeModel.darkTheme,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const MyHomePage(),
            '/chats': (context) => const Chates(),
            StorySlider.routeName: (context) => const StorySlider(),
          },
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
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  void changeSelectedIndex(int value) {
    setState(() {
      selectedIndex = value;
    });
  }

  final PageController controller = PageController();

  final Map<int, GlobalKey> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
    4: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Stack(
        children: [
          Offstage(
            offstage: selectedIndex != 0,
            child: CustomNavigator(
              widget: const HomePage(),
              navigatorKey: navigatorKeys[0]!,
            ),
          ),
          Offstage(
            offstage: selectedIndex != 1,
            child: CustomNavigator(
              widget: const Scaffold(
                body: Center(
                  child: Text('Search'),
                ),
              ),
              navigatorKey: navigatorKeys[1]!,
            ),
          ),
          Offstage(
            offstage: selectedIndex != 2,
            child: CustomNavigator(
              widget: const Center(
                child: Text('Add Post'),
              ),
              navigatorKey: navigatorKeys[2]!,
            ),
          ),
          Offstage(
            offstage: selectedIndex != 3,
            child: CustomNavigator(
              widget: const Center(
                child: Text('Likes'),
              ),
              navigatorKey: navigatorKeys[3]!,
            ),
          ),
          Offstage(
            offstage: selectedIndex != 4,
            child: CustomNavigator(
              widget: const Center(
                child: Text('Profile'),
              ),
              navigatorKey: navigatorKeys[4]!,
            ),
          ),
        ],
        // onPageChanged: (index) {
        //   setState(() {
        //     selectedIndex = index;
        //   });
        // },
      ),
      bottomNavigationBar: BottomNavBar(
        controller: controller,
        selectedIndex: selectedIndex,
        changeSelectedIndex: changeSelectedIndex,
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {super.key,
      required this.controller,
      required this.selectedIndex,
      required this.changeSelectedIndex});
  final int selectedIndex;
  final PageController controller;
  final Function changeSelectedIndex;

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
              // controller.animateToPage(0,
              //     duration: const Duration(milliseconds: 500),
              //     curve: Curves.ease)
              changeSelectedIndex(0)
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
              // controller.animateToPage(1,
              //     duration: const Duration(milliseconds: 500),
              //     curve: Curves.ease)
              changeSelectedIndex(1)
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
              // controller.animateToPage(2,
              //     duration: const Duration(milliseconds: 500),
              //     curve: Curves.ease)
              changeSelectedIndex(2)
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
              // controller.animateToPage(3,
              //     duration: const Duration(milliseconds: 500),
              //     curve: Curves.ease)
              changeSelectedIndex(3)
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
              // controller.animateToPage(4,
              //     duration: const Duration(milliseconds: 500),
              //     curve: Curves.ease)
              changeSelectedIndex(4)
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

class CustomNavigator extends StatelessWidget {
  const CustomNavigator(
      {Key? key, required this.navigatorKey, required this.widget})
      : super(key: key);
  final GlobalKey navigatorKey;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) {
            return widget;
          },
          settings: settings,
        );
      },
    );
  }
}
