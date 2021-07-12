import 'package:flutter/material.dart';

class HeadWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String text;
  const HeadWidget({Key key, this.scaffoldKey, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(children: [
      SizedBox(
        height: size.height * .05,
      ),
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white, size: 30),
              onPressed: () => scaffoldKey.currentState.openDrawer(),
            ),
            Text(text, style: TextStyle(fontSize: 22)),
            SizedBox(
              width: size.height * .02,
            ),
          ]),
      SizedBox(
        height: size.height * .01,
      ),
    ]);
  }
}
