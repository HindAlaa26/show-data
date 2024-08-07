import 'package:flutter/material.dart';
import 'package:show_data/models/instructor.dart';

sealed class InstructorState {}

final class InstructorLoadingState extends InstructorState {}

final class InstructorLoadedState extends InstructorState {
  final List<Instructor> instructors;
  final Map<int, ValueNotifier<int>> rateNotifiers;

  InstructorLoadedState(this.instructors, this.rateNotifiers);
}

final class InstructorErrorState extends InstructorState {
  final String error;
  InstructorErrorState(this.error);
}
