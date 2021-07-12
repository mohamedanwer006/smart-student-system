import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triple_s_project/helprs/constant.dart';
import 'package:triple_s_project/helprs/end_points.dart';
import 'package:triple_s_project/model/subjectById.dart';
import 'package:triple_s_project/model/subjects.dart';
import 'package:triple_s_project/model/user.dart';

class SubjectsProvider extends ChangeNotifier {
  final _helper = Constant.helper;
  SubjectsResponse subjectsResponse;
  List<Subject> _subjects = [];
  List<Subject> get subjects {
    return _subjects;
  }

  Future<void> getSubjects() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final user =
          User.fromJson(json.decode(sharedPreferences.get(USERSHAERED)));
      final response = await _helper.get(SUJECTS + user.token);
      subjectsResponse = SubjectsResponse.fromJson(response);
      _subjects = subjectsResponse.data;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  SubjectById _selectedSubjectByid;
  SubjectById get selectedSubjectByid {
    return _selectedSubjectByid;
  }

  bool subjectHasDataState = false;
  Future<void> getSubjectById({String id}) async {
    try {
      _selectedSubjectByid = null;
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final user =
          User.fromJson(json.decode(sharedPreferences.get(USERSHAERED)));
      final response =
          await _helper.post(SUBJECTBYID + user.token, {"subject_id": id});
      SubjectByIdRes selectedSubjectByidResponse =
          SubjectByIdRes.fromJson(response);
      _selectedSubjectByid = selectedSubjectByidResponse.data;
      _selectedSubjectByid.quiz.map((quiz) {
        quiz.questions.map((q) {
          q.choisesList.addAll(q.choises.split(','));
        }).toList();
      }).toList();
      subjectHasDataState = true;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  attemptQuiz(int quizId) {
    _selectedSubjectByid.quiz[quizId].isAttempted = true;
  }

  quizAnswerSaving(String selectedAnswerId, int qesId, int quizId) {
    _selectedSubjectByid.quiz[quizId].questions[qesId].stdnswer =
        selectedAnswerId;
    quizCheckAllSelected(quizId);
  }

  quizAnswerRemoving(String selectedAnswerId, int qesId, int quizId) {
    _selectedSubjectByid.quiz[quizId].questions[qesId].stdnswer = '';
    quizCheckAllSelected(quizId);
  }

  bool allSelected = false;
  bool quizCheckAllSelected(int quizId) {
    allSelected = _selectedSubjectByid.quiz[quizId].questions
        .every((e) => e.stdnswer != '');
    notifyListeners();
    return allSelected;
  }

  List<int> quizCalc(int quizId) {
    int res = 0;
    int total = 0;
    _selectedSubjectByid.quiz[quizId].questions.map((e) {
      total += int.parse(e.degree);
    }).toList();
    _selectedSubjectByid.quiz[quizId].questions.map((e) {
      if (e.ans == e.stdnswer) res += int.parse(e.degree);
    }).toList();
    allSelected = false;
    return [res, total];
  }
}
