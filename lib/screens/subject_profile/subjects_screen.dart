import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triple_s_project/model/subjects.dart';
import 'package:triple_s_project/providers/allSubjects.dart';
import 'subject_detail_screen.dart';
import '../../widgets/main_drawer.dart';

class AllSubject extends StatefulWidget {
  static const routeName = 'all_subjects';

  @override
  _AllSubjectState createState() => _AllSubjectState();
}

class _AllSubjectState extends State<AllSubject> {
  @override
  void initState() {
    super.initState();
    Provider.of<SubjectsProvider>(context, listen: false).getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    List<Subject> subjects = Provider.of<SubjectsProvider>(context).subjects;
    return Scaffold(
        // drawer: MainDrawer(),
        appBar: AppBar(
          title: Text(
            'Subjects',
            style: Theme.of(context).textTheme.headline6,
          ),
          centerTitle: true,
        ),
        body: subjects.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: subjects
                      .map((e) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            elevation: 6.0,
                            color: Colors.white54,
                            margin: EdgeInsets.all(15.0),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => SubjectDetailScreen(
                                          subject: e,
                                        )));
                              },
                              leading: Image.asset("images/subject.png"),
                              title: Text(e.name,
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 20.0, fontFamily: 'Satisfy')),
                            ),
                          )))
                      .toList(),
                ),
              ));
  }
}
//  ListView.builder(
//   itemCount: subjects.length,
//   itemBuilder: (ctx, index) {
//     return Card(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25.0)),
//       elevation: 6.0,
//       color: Colors.white54,
//       margin: EdgeInsets.all(15.0),
//       child: ListTile(
//         onTap: () {
//           Navigator.of(context).pushNamed(SubjectDetailScreen.routeName,
//               arguments: subjects[index].id);
//         },
//         leading: Text(subjects[index].name,
//             textAlign: TextAlign.center,
//             style: new TextStyle(fontSize: 20.0, fontFamily: 'Satisfy')),
//       ),
//     );
//   },
// ),
