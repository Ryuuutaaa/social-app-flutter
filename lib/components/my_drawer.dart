import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // drawer header
          DrawerHeader(
            child: Icon(Icons.favorite),
          ),

          // home tile
          ListTile(
            leading: Icon(Icons.home),
            title: Text("H O M E"),
            onTap: () {},
          )

          // profile user

          // users title
        ],
      ),
    );
  }
}
