import 'package:firstapp/core/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('nick_p'),
            accountEmail: Text('kolianpylupc@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/avatar.jpg'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return ListTile(
                leading: (state.isLightTheme)
                    ? const Icon(Icons.sunny)
                    : const Icon(Icons.dark_mode),
                title: const Text('App theme'),
                onTap: () {
                  BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
                },
              );
            },
          ),
          const AboutListTile(
            icon: Icon(Icons.info),
            applicationIcon: Icon(
              Icons.camera_alt_outlined,
            ),
            applicationName: 'Instagram clone',
            applicationVersion: '2.0',
            applicationLegalese: '© 2023 Empat Flutter',
            child: Text('About app'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
