import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triple_s_project/helprs/constant.dart';
import 'package:triple_s_project/helprs/end_points.dart';

import 'package:triple_s_project/model/user.dart';

class Auth extends ChangeNotifier {
  final _helper = Constant.helper;
  UserRes _logInResponse;
  User _user;
  bool _isActiveRememberMe = false;
  User get user {
    return _user;
  }

  Future<bool> login({@required String fId, @required String nId}) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final response = await _helper.post(LOGINURL,
          {"national_id": nId, "faculty_id": fId, "FCM_token": "1234242456"});
      _logInResponse = UserRes.fromJson(response);
      if (_logInResponse.status == PASS) {
        _user = _logInResponse.user;
        sharedPreferences.setString(USERSHAERED, json.encode(_user.toJson()));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> logout() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final response = await _helper.post(LOGOUTURL, {"id": user.id});
      // if (response['status'] == 1) {
      _user = null;
      sharedPreferences.clear();
      notifyListeners();
      // }
    } catch (e) {}
  }

  Future<bool> isSigning() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.get(USERSHAERED) != null) {
        final user =
            User.fromJson(json.decode(sharedPreferences.get(USERSHAERED)));
        if (user.token != null) {
          _user = user;
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }




  /// دي الليست الي هتسخدميها في عرض مواد اليوم
  List<TableSubject> selectedSubjects = [];

  ///  دي الفانكشن الي هتغيري بيها اليوم
  ///  هتبعتلها الليست الجديدة
  void changeSelectedSubjects(List<TableSubject> listSubject) {
    selectedSubjects = listSubject;
    notifyListeners();
  }
}
