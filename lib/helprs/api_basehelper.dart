import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triple_s_project/model/user.dart';

import 'end_points.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://www.trpls.co/api/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
        body: json.encode(body),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('NO_INTERNET');
    }
    return responseJson;
  }
  Future<int> uploadAssignment(
      {@required String subjectId,
        @required String assignmentId,
        @required String professorId,
        @required String filePath}) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final user = User.fromJson(json.decode(sharedPreferences.get(USERSHAERED)));
    var request = http.MultipartRequest(
        'POST', Uri.parse(_baseUrl + AssignmentFile + user.token))
      ..fields['subject_id'] = subjectId
      ..fields['professor_id'] = professorId
      ..fields['assignment_id'] = assignmentId;
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    var res = await request.send();
    var resData = await res.stream.bytesToString();
    print(res.statusCode);
    print(resData);
    return res.statusCode;
  }
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 422:
        throw response.body.toString();
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        print(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode} ${response.body}');
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode} ${response.body}');
    }
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
