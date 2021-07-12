import 'package:flutter/material.dart';

class ExamsSchedule extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<ExamsSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(

            title: Text(
              'Exams Schedule',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )));
  }
}