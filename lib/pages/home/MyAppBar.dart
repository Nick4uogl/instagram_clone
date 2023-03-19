import 'package:flutter/material.dart';
import 'package:firstapp/pages/chates.dart';
import 'package:firstapp/data/icons.dart';

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
      leading: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () => globalKey.currentState!.openDrawer(),
          ),
          IconButton(
            icon: cameraIcon,
            onPressed: null,
          ),
        ],
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
    );
  }
}
