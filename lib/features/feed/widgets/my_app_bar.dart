import 'package:flutter/material.dart';
import 'package:firstapp/features/chats/chates.dart';
import 'package:firstapp/core/data/icons.dart';
import 'package:flutter_svg/svg.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({super.key, required this.globalKey});
  final GlobalKey<ScaffoldState> globalKey;

  @override
  Size get preferredSize => const Size.fromHeight(44.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leadingWidth: 90,
      toolbarHeight: 44,
      centerTitle: true,
      iconTheme: Theme.of(context).iconTheme,
      backgroundColor: Theme.of(context).primaryColor,
      leading: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.menu,
            ),
            onPressed: () => globalKey.currentState!.openDrawer(),
          ),
          IconButton(
            icon: SvgPicture.asset(
              'images/CameraIcon.svg',
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: null,
          ),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          SvgPicture.asset(
            'images/InstagramLogo.svg',
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: null,
          icon: SvgPicture.asset(
            'images/IGTV.svg',
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Chates()),
            );
          },
          icon: SvgPicture.asset(
            'images/Messanger.svg',
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }
}
