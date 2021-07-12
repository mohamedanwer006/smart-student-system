// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UserRes welcomeFromJson(String str) => UserRes.fromJson(json.decode(str));

String welcomeToJson(UserRes data) => json.encode(data.toJson());

class UserRes {
  UserRes({
    this.status,
    this.message,
    this.user,
  });

  final String status;
  final String message;
  final User user;

  factory UserRes.fromJson(Map<String, dynamic> json) => UserRes(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        user: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": user == null ? null : user.toJson(),
      };
}

class User {
  User({
    this.id,
    this.timestamps,
    this.name,
    this.email,
    this.password,
    this.nationalId,
    this.facultyId,
    this.department,
    this.grade,
    this.groupId,
    this.token,
    this.fcmToken,
    this.table,
    this.image
  });

  final String id;
  final DateTime timestamps;
  final String name;
  final String email;
  final String password;
  final String nationalId;
  final String facultyId;
  final String department;
  final String grade;
  final String groupId;
  final String token;
  final String fcmToken;
  final List<Table> table;
  final String image ;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        timestamps: json["timestamps"] == null
            ? null
            : DateTime.parse(json["timestamps"]),
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        nationalId: json["national_id"] == null ? null : json["national_id"],
        facultyId: json["faculty_id"] == null ? null : json["faculty_id"],
        department: json["department"] == null ? null : json["department"],
        grade: json["grade"] == null ? null : json["grade"],
        groupId: json["group_id"] == null ? null : json["group_id"],
        token: json["token"] == null ? null : json["token"],
        fcmToken: json["FCM_token"] == null ? null : json["FCM_token"],
        table: json["table"] == null
            ? null
            : List<Table>.from(json["table"].map((x) => Table.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "timestamps": timestamps == null ? null : timestamps.toIso8601String(),
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "national_id": nationalId == null ? null : nationalId,
        "faculty_id": facultyId == null ? null : facultyId,
        "department": department == null ? null : department,
        "grade": grade == null ? null : grade,
        "group_id": groupId == null ? null : groupId,
        "token": token == null ? null : token,
        "FCM_token": fcmToken == null ? null : fcmToken,
        "table": table == null
            ? null
            : List<dynamic>.from(table.map((x) => x.toJson())),
      };
}

class Table {
  Table({
    this.id,
    this.dayId,
    this.subjects,
  });

  final String id;
  final String dayId;
  final List<TableSubject> subjects;

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        id: json["id"] == null ? null : json["id"],
        dayId: json["day_id"] == null ? null : json["day_id"],
        subjects: json["subjects"] == null
            ? null
            : List<TableSubject>.from(
                json["subjects"].map((x) => TableSubject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "day_id": dayId == null ? null : dayId,
        "subjects": subjects == null
            ? null
            : List<dynamic>.from(subjects.map((x) => x.toJson())),
      };
}

class TableSubject {
  TableSubject({
    this.subject,
    this.professor,
    this.department,
    this.online,
    this.place,
    this.lecTime,
  });

  final String subject;
  final String professor;
  final String department;
  final String online;
  final String place;
  final String lecTime;

  factory TableSubject.fromJson(Map<String, dynamic> json) => TableSubject(
        subject: json["subject"] == null ? null : json["subject"],
        professor: json["professor"] == null ? null : json["professor"],
        department: json["department"] == null ? null : json["department"],
        online: json["online"] == null ? null : json["online"],
        place: json["place"] == null ? null : json["place"],
        lecTime: json["lec_time"] == null ? null : json["lec_time"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject == null ? null : subject,
        "professor": professor == null ? null : professor,
        "department": department == null ? null : department,
        "online": online == null ? null : online,
        "place": place == null ? null : place,
        "lec_time": lecTime == null ? null : lecTime,
      };
}
