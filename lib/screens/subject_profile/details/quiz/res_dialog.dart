import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResDialog extends StatelessWidget {
  final int res;
  final int total;
  const ResDialog({Key key, this.res, this.total}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: AlertDialog(
            actions: [
              FlatButton(
                child: Text("OK",
                    style: TextStyle(color: Colors.pink, fontSize: 22)),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  padding: EdgeInsets.all(32),
                  child: Text('$res / $total',
                      style: TextStyle(color: Colors.pink, fontSize: 30))),
            ]),
            title: Center(
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text("Your Reselt :-",
                        style: TextStyle(color: Colors.pink, fontSize: 30))))));
  }
}
