import 'package:flutter/material.dart';

class Exams extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Exams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: Text(
              'Exams',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )));
  }
}