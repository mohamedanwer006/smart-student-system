import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:triple_s_project/widgets/auto_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/auth.dart';
import 'results.dart';
import '../subject_profile/subjects_screen.dart';
import '../../widgets/main_drawer.dart';

class MyHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const routeName = 'My_home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          elevation: 0,
        ),
        key: scaffoldKey,
        drawer: MainDrawer(),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            Text("Grow Your own Skill \n  by Online Learing",
                style: TextStyle(fontSize: 22)),
            HeadLine("News"),
            CarouselWithIndicator(),
            HeadLine("E-learning"),
            ElearingGrid(),
            HeadLine("Web Sites"),
            WebSitesGrid()
          ])))
        ]));
  }
}

class HeadLine extends StatelessWidget {
  final String text;

  const HeadLine(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(text, style: TextStyle(fontSize: 22)))
        ],
      ),
    );
  }
}

class ElearingGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<Auth>(context).user;

    return Container(
        height: deviceSize.height * 0.55,
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          children: <Widget>[
            _buildHomeCard(
              'All Subjects',
              () {
                Navigator.of(context).pushNamed(AllSubject.routeName);
              },
            ),
            _buildHomeCard(
              'Online Session',
              () {
                Navigator.pushNamed(context, '/online');
              },
            ),
            _buildHomeCard(
              'Exams',
              () {
                Navigator.pushNamed(context, '/Exams Tables');
              },
            ),
            _buildHomeCard(
              'Final Results',
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => ResultsScreen(
                              table: user.table,
                            )));
              },
            ),
          ],
        ));
  }

  Widget _buildHomeCard(String title, Function function) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 2.0,
        color: Colors.white,
        margin: EdgeInsets.all(8.0),
        child: InkWell(
            onTap: function,
            splashColor: Colors.blue[50],
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.text_snippet,
                    color: Colors.pink,
                    size: 55,
                  ),
                  Text(title,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Satisfy',
                          color: Colors.black)),
                ])));
  }
}

class WebSitesGrid extends StatelessWidget {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<Auth>(context).user;

    return Container(
        height: deviceSize.height * .3,
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          children: <Widget>[
            _buildHomeCard(
              'Alfarabi',
              () {
                _launchURL("https://alfarabi.mans.edu.eg/login");
              },
            ),
            _buildHomeCard(
              'MULMS',
              () {
                _launchURL("https://vc1.mans.edu.eg/moodle02/login/index.php");
              },
            ),
          ],
        ));
  }

  Widget _buildHomeCard(String title, Function function) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 2.0,
        color: Colors.white,
        margin: EdgeInsets.all(8.0),
        child: InkWell(
            onTap: function,
            splashColor: Colors.blue[50],
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.text_snippet,
                    color: Colors.pink,
                    size: 55,
                  ),
                  Text(title,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Satisfy',
                          color: Colors.black)),
                ])));
  }
}
