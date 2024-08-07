import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_data/bloc/instructor_event.dart';
import 'package:show_data/bloc/instructor_states.dart';
import 'package:show_data/repository/instructor_repository.dart';

class InstructorBloc extends Bloc<InstructorEvent, InstructorState> {
  final InstructorRepository _instructorRepository;

  InstructorBloc(this._instructorRepository) : super(InstructorLoadingState()) {
    on<LoadInstructorEvent>(loadInstructor);
  }

  Future<void> loadInstructor(
      LoadInstructorEvent event, Emitter<InstructorState> emit) async {
    emit(InstructorLoadingState());
    try {
      final instructors = await _instructorRepository.getInstructors();
      final rateNotifiers = <int, ValueNotifier<int>>{};
      for (var instructor in instructors) {
        rateNotifiers[instructor.id] = ValueNotifier(0);
      }
      emit(InstructorLoadedState(instructors, rateNotifiers));
    } catch (error) {
      emit(InstructorErrorState(error.toString()));
    }
  }
}
