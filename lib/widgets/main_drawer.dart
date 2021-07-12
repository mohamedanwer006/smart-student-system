import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triple_s_project/providers/theme_provider.dart';
import '../providers/auth.dart';
import '../screens/home/home_page.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;
    var themeMode = Provider.of<ThemeProvider>(context).tm;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              width: 250,
              // padding: EdgeInsets.all(8),
              child: ListView(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: CircleAvatar(
                  //     radius: 40,
                  //     backgroundImage: NetworkImage(user.image ?? ''),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      height: 0.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.department,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      height: 0.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.grade,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      height: 0.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  customDrawerItem(themeMode, context, () {
                    Navigator.of(context)
                        .pushReplacementNamed(MyHome.routeName);
                  }, Icons.home, 'Home'),
                  customDrawerItem(themeMode, context, () {
                    Navigator.pushNamed(context, '/std');
                  }, Icons.person, 'Student Info'),
                  customDrawerItem(themeMode, context, () {}, Icons.table_view,
                      'Study Timetable'),
                  customDrawerItem(themeMode, context, () {}, Icons.description,
                      'Academic Results'),
                  customDrawerItem(themeMode, context, () {},
                      Icons.menu_book_sharp, 'Courses'),
                  customDrawerItem(themeMode, context, () {
                    Navigator.pushNamed(context, '/notification');
                  }, Icons.notification_important_outlined, 'Notification'),
                  customDrawerItem(
                      themeMode, context, () {}, Icons.settings, 'Settings'),
                  customDrawerItem(themeMode, context, () async {
                    await Provider.of<Auth>(context, listen: false).logout();
                  }, Icons.logout, 'Log out'),
                ],
              ),
            ),
          ),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: Duration(milliseconds: 500),
              builder: (_, double val, __) {
                return (Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200 * val)
                    ..rotateY(
                      (pi / 3 * val),
                    ),
                  child: MyHome(),
                ));
              }),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget customDrawerItem(
    ThemeMode themeMode,
    context,
    Function navigateTo,
    IconData icon,
    String text,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.blue[300],
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Icon(icon, size: 30, color: Colors.white),
            title: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            onTap: navigateTo,
          ),
        ),
      ),
    );
  }
}
