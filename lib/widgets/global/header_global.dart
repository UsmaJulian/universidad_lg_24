import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, double? height = 93})
      : preferredSize = Size.fromHeight(height!);
  @override
  final Size preferredSize;

  Size get getPreferredSize => preferredSize;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.15,
      backgroundColor: bgColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 21),
        child: Image.asset(
          'assets/images/Grupo 77.png',
        ),
      ),
      leadingWidth: 110,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 21),
          child: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: mainColor, size: 43),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
