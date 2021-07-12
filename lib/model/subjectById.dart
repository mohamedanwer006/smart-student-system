// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SubjectByIdRes fromJson(String str) =>
    SubjectByIdRes.fromJson(json.decode(str));

String toJson(SubjectByIdRes data) => json.encode(data.toJson());

class SubjectByIdRes {
  SubjectByIdRes({
    this.status,
    this.message,
    this.data,
  });

  final String status;
  final String message;
  final SubjectById data;

  factory SubjectByIdRes.fromJson(Map<String, dynamic> json) => SubjectByIdRes(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : SubjectById.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class SubjectById {
  SubjectById({
    this.quiz,
    this.assignments,
    this.banks,
  });

  final List<Quiz> quiz;
  final List<Assignment> assignments;
  final List<Assignment> banks;

  factory SubjectById.fromJson(Map<String, dynamic> json) => SubjectById(
        quiz: json["quiz"] == null
            ? null
            : List<Quiz>.from(json["quiz"].map((x) => Quiz.fromJson(x))),
        assignments: json["assignments"] == null
            ? null
            : List<Assignment>.from(
                json["assignments"].map((x) => Assignment.fromJson(x))),
        banks: json["banks"] == null
            ? null
            : List<Assignment>.from(
                json["banks"].map((x) => Assignment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quiz": quiz == null
            ? null
            : List<dynamic>.from(quiz.map((x) => x.toJson())),
        "assignments": assignments == null
            ? null
            : List<dynamic>.from(assignments.map((x) => x.toJson())),
        "banks": banks == null
            ? null
            : List<dynamic>.from(banks.map((x) => x.toJson())),
      };
}

class Assignment {
  Assignment({
    this.id,
    this.timestamps,
    this.title,
    this.fileUrl,
    this.gradeId,
    this.subjectId,
    this.departmentId,
  });

  final String id;
  final DateTime timestamps;
  final String title;
  final String fileUrl;
  final String gradeId;
  final String subjectId;
  final String departmentId;

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        id: json["id"] == null ? null : json["id"],
        timestamps: json["timestamps"] == null
            ? null
            : DateTime.parse(json["timestamps"]),
        title: json["title"] == null ? null : json["title"],
        fileUrl: json["file_URL"] == null ? null : json["file_URL"],
        gradeId: json["grade_id"] == null ? null : json["grade_id"],
        subjectId: json["subject_id"] == null ? null : json["subject_id"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "timestamps": timestamps == null ? null : timestamps.toIso8601String(),
        "title": title == null ? null : title,
        "file_URL": fileUrl == null ? null : fileUrl,
        "grade_id": gradeId == null ? null : gradeId,
        "subject_id": subjectId == null ? null : subjectId,
        "department_id": departmentId == null ? null : departmentId,
      };
}

class Quiz {
  Quiz({
    this.id,
    this.timestamps,
    this.name,
    this.questions,
  });

  final String id;
  final DateTime timestamps;
  final String name;
  final List<Question> questions;
  bool isAttempted = false;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"] == null ? null : json["id"],
        timestamps: json["timestamps"] == null
            ? null
            : DateTime.parse(json["timestamps"]),
        name: json["name"] == null ? null : json["name"],
        questions: json["questions"] == null
            ? null
            : List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "timestamps": timestamps == null ? null : timestamps.toIso8601String(),
        "name": name == null ? null : name,
        "questions": questions == null
            ? null
            : List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.id,
    this.timestamps,
    this.ques,
    this.choises,
    this.ans,
    this.degree,
  });

  final String id;
  final DateTime timestamps;
  final String ques;
  String choises;
  final String ans;
  final String degree;
  List<String> choisesList = [];
  String stdnswer = '';
  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"] == null ? null : json["id"],
        timestamps: json["timestamps"] == null
            ? null
            : DateTime.parse(json["timestamps"]),
        ques: json["ques"] == null ? null : json["ques"],
        choises: json["choises"] == null ? null : json["choises"],
        ans: json["ans"] == null ? null : json["ans"],
        degree: json["degree"] == null ? null : json["degree"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "timestamps": timestamps == null ? null : timestamps.toIso8601String(),
        "ques": ques == null ? null : ques,
        "choises": choises == null ? null : choises,
        "ans": ans == null ? null : ans,
        "degree": degree == null ? null : degree,
      };
}
