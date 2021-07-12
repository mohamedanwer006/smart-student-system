import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triple_s_project/Animation/FadeAnimation.dart';
import 'package:triple_s_project/providers/auth.dart';
import 'package:triple_s_project/providers/theme_provider.dart';
import 'package:triple_s_project/screens/home/home_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool loading = false;
  bool obscureText = false;
  String fId, nId;
  _login() async {
    if (!globalKey.currentState.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });
    try {
      print(fId + nId);
      bool isAuth = await Provider.of<Auth>(context, listen: false)
          .login(fId: fId, nId: nId);
      print("111111111111");
      if (isAuth) {
        Navigator.pushReplacementNamed(context, MyHome.routeName);
      } else {
        //  TODO : Toast
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeMode = Provider.of<ThemeProvider>(context).tm;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Form(
        key: globalKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1,
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'images/login_image.jpg',
                      )),
                  height: 220,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FadeAnimation(
                1.3,
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person,
                        color: themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black),
                    hintText: 'National ID ',
                    hintStyle: TextStyle(
                        color: themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black),
                    focusColor: themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.blue[200],
                    fillColor: Colors.white38,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue[200],
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  onChanged: (val) {
                    nId = val;
                  },
                  validator: (val) =>
                  val.isEmpty ? 'Enter your ID ' : null,
                  obscureText: false,
                ),
              ),
              SizedBox(height: 20.0),
              FadeAnimation(
                1.7,
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Faculty ID',
                        hintStyle: TextStyle(
                            color: themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black),
                        prefixIcon: Icon(Icons.lock,
                            color: themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black),
                        focusColor: themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.purple[300],
                        fillColor: Colors.white38,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue[200],
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      onChanged: (val) {
                        fId = val;
                      },
                      validator: (val) =>
                      val.length < 5 ? ' Enter a password   ' : null,
                      obscureText: obscureText,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.blue[200],
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60.0),
              FadeAnimation(
                2.6,
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RaisedButton(
                      color: Colors.blue[200],
                      onPressed: _login,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lobster',
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  // : CircularProgressIndicator(),
                ),
              ),
              //  : CircularProgressIndicator(),
            ],
          ),
        ),
      )),
    ));
  }
}
