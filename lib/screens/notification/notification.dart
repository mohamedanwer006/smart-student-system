import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triple_s_project/providers/auth.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(
          'Notification Screen',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        )),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(2.0),
                child: NotificationWidget(
                  img: 'images/subject.png',
                  time: DateTime.now(),
                  title: 'Dr:nehal add new lecture',
                ));
          },
        ));
  }
}

//create notification widget
class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key key, this.title, this.time, this.img})
      : super(key: key);

  final String title;
  final DateTime time;
  final String img;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: Colors.grey))),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(img),
        ),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black)),
        subtitle: Text(time.toString(),
            style: Theme.of(context)
                .textTheme
                .body2
                .copyWith(color: Colors.black)),
        tileColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 5, bottom: 5, right: 0),
      ),
    );
  }
}
