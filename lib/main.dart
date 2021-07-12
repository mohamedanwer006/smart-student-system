//29804091200652
// 1000065317
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triple_s_project/screens/auth/login_screen.dart';
import 'providers/allSubjects.dart';
import 'providers/auth.dart';
import 'providers/theme_provider.dart';
import 'screens/home/exam_schedule.dart';
import 'screens/home/home_page.dart';
import 'screens/home/online.dart';
import 'screens/home/results.dart';
import 'screens/notification/notification.dart';
import 'screens/student_info_screen.dart';
import 'screens/subject_profile/details/bank/all_banks_screen.dart';
import 'screens/subject_profile/details/exam/exams.dart';
import 'screens/subject_profile/details/report/reports.dart';
import 'screens/subject_profile/subject_detail_screen.dart';
import 'screens/subject_profile/subjects_screen.dart';
import 'screens/theme_settings.dart';
import 'widgets/main_splash_scrseen.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider()..getThemeMode(),
      ),
      ChangeNotifierProvider<Auth>(
        create: (context) => Auth(),
      ),
      ChangeNotifierProvider<SubjectsProvider>(
        create: (context) => SubjectsProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      theme: ThemeData(
          cardColor: Colors.black87,
          buttonColor: Colors.black87,
          //primarySwatch: primaryColor,
          accentColor: accentColor,
          // canvasColor: Colors.black87,
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
                headline6: TextStyle(
                    color: Colors.black87,
                    fontSize: 19,
                    fontFamily: 'Satisfy',
                    fontWeight: FontWeight.bold),
              )),
      darkTheme: ThemeData(
          unselectedWidgetColor: Colors.white70,
          cardColor: Colors.white,
          buttonColor: Colors.white,
          //primarySwatch: primaryColor,
          accentColor: accentColor,
          canvasColor: Color.fromRGBO(14, 22, 33, 1),
          textTheme: ThemeData.dark().textTheme.copyWith(
                bodyText1: TextStyle(color: Colors.white),
                headline6: TextStyle(
                    color: Colors.white70,
                    fontSize: 19,
                    fontFamily: 'Satisfy',
                    fontWeight: FontWeight.bold),
              )),
      routes: {
        'main_splash': (context) => MainSplashScreen(),
        'LoginScreen': (context) => LoginScreen(),
        MyHome.routeName: (context) => MyHome(),
        Reports.routeName: (context) => Reports(),
        '/online': (context) => OnLine(),
        '/exams': (context) => Exams(),
        // ALLQuizzesScreen.routeName: (context) => ALLQuizzesScreen(),
        '/results': (context) => ResultsScreen(),
        '/Exams Schedule': (context) => ExamsSchedule(),
        '/std': (context) => StudentInfo(),
        '/notification': (context) => NotificationScreen(),
        '/settings': (context) => ThemesScreen(),
        AllSubject.routeName: (context) => AllSubject(),
        SubjectDetailScreen.routeName: (context) => SubjectDetailScreen(),
        Banks.routeName: (context) => Banks(),
      },
      home: Consumer<Auth>(
          builder: (context, auth, child) => FutureBuilder<bool>(
              future: auth.isSigning(),
              builder: (ctx, sh) {
                if (sh.connectionState == ConnectionState.waiting) {
                  return MainSplashScreen();
                } else if (sh.data) {
                  return MyHome();
                } else {
                  return LoginScreen();
                }
              })),
    );
  }
}
