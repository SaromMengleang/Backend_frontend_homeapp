import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'student_model.dart';

StudentModel studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentService {
  static Future<StudentModel> read() async {
    final String url = "http://10.0.2.2:8000/api/students?page=1";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return compute(studentModelFromJson, response.body);
      } else {
        throw Exception("Error status code: ${response.statusCode}\nBody: ${response.body}");
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }

  static Future<bool> insert(Datum item) async {
    final String url = "http://10.0.2.2:8000/api/students";
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Error status code: ${response.statusCode}\nBody: ${response.body}");
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }

  static Future<bool> update(Datum item) async {
    final String url = "http://10.0.2.2:8000/api/students/${item.id}";
    try {
      http.Response response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Error status code: ${response.statusCode}\nBody: ${response.body}");
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }

  static Future<bool> delete(int id) async {
    final String url = "http://10.0.2.2:8000/api/students/$id";
    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Error status code: ${response.statusCode}\nBody: ${response.body}");
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }
}
