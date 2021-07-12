import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselWithIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<Widget> widgets = [
      SliderItem('images/slide1.jpg', 'Mansoura metro sport'),
      SliderItem('images/slide2.jpg', 'Safe exit training'),
      SliderItem('images/slide3.jpg', 'Excellent Award'),
    ];
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        height: size.height * .25,
        width: size.width,
        child: CarouselSlider(
          items: widgets,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              // aspectRatio: 3.0,
              height: size.height * 20,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets
              .map(
                (e) => Container(
                  width: size.width * .02,
                  height: size.width * .02,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(8),
                      color: _current == widgets.indexOf(e)
                          ? Colors.blue
                          : Colors.white),
                ),
              )
              .toList()),
    ]);
  }
}

class SliderItem extends StatelessWidget {
  final String image, text;
  SliderItem(this.image, this.text);
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
    return GestureDetector(
        onTap: () async {
          await _launchURL(
              "https://engfac.mans.edu.eg/index.php/2020-08-06-10-40-47/3837-safe-evacuation-test");
        },
        child: Stack(children: [
          Positioned.fill(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                  ))),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(text, style: TextStyle(fontSize: 12)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Colors.black87,
                    ),
                    width: double.infinity,
                    height: 50,
                  ))),
        ]));
  }
}
