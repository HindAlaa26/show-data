import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:show_data/models/instructor.dart';

class InstructorRepository {
  Future<List<Instructor>> getInstructors() async {
    try {
      var result = await rootBundle.loadString("assets/data.json");
      var decoded = json.decode(result) as List;
      var instructors =
          decoded.map((json) => Instructor.fromJson(json)).toList();
      return instructors;
    } on Exception {
      rethrow;
    }
  }
}
