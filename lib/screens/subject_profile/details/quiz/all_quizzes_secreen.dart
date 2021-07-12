import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triple_s_project/model/subjectById.dart';
import 'package:triple_s_project/providers/allSubjects.dart';
import 'package:triple_s_project/screens/subject_profile/details/quiz/quiz_screen.dart';

class ALLQuizzesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Quiz> allQuizes =
        Provider.of<SubjectsProvider>(context).selectedSubjectByid.quiz;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Quizzes',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      )),
      body: Column(
          children: allQuizes
              .map(
                (e) => _buildCard(e, Icons.question_answer, () {
                  if (!e.isAttempted)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => QuizScreen(
                          quiz: e,
                          quizId: allQuizes.indexOf(e),
                        ),
                      ),
                    );
                  else
                    showDialog(
                        useRootNavigator: false,
                        context: context,
                        builder: (ctx) => AttemptDialog());
                }),
              )
              .toList()),
    );
  }

  Widget _buildCard(Quiz q, IconData icon, Function function) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          elevation: 6.0,
          color: Colors.white54,
          margin: EdgeInsets.all(15.0),
          child: Center(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              onTap: function,
              leading: Icon(icon,
                  size: 30, color: q.isAttempted ? Colors.red : Colors.green),
              title: Text(q.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Satisfy')),
            ),
          ),
        ));
  }
}

class AttemptDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: AlertDialog(
            actions: [
              FlatButton(
                child: Text("OK",
                    style: TextStyle(color: Colors.pink, fontSize: 22)),
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
              )
            ],
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  padding: EdgeInsets.all(32),
                  child: Text('You Have Already Attended This Quiz',
                      style: TextStyle(color: Colors.pink, fontSize: 18))),
            ]),
            title: Center(
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text("Sorry :-",
                        style: TextStyle(color: Colors.pink, fontSize: 30))))));
  }
}
