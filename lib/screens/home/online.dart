import 'package:flutter/material.dart';
class OnLine extends StatefulWidget {
  @override
  _OnLineState createState() => _OnLineState();
}

class _OnLineState extends State<OnLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: Text(
              'Online Session',
              style: Theme.of(context).textTheme.headline6,
            )));
  }
}
