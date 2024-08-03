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
    await _instructorRepository.getInstructors().then((instructors) {
      emit(InstructorLoadedState(instructors));
    }).catchError((error) {
      emit(InstructorErrorState(error.toString()));
    });
  }
}
