import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_data/bloc/instructor_bloc.dart';
import 'package:show_data/bloc/instructor_event.dart';
import 'package:show_data/bloc/instructor_states.dart';
import 'package:show_data/screens/home.dart';
import '../models/instructor.dart';

class ShowDataScreen extends StatelessWidget {
  final Instructor instructor;

  const ShowDataScreen({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Instructor Data'),
        ),
        body: Column(children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: Colors.blueGrey,
            backgroundImage: NetworkImage(instructor.image),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            instructor.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 25,
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Instructor name : ${instructor.name}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'Instructor Subjects :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '1. ${instructor.subjects[0]}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  '2. ${instructor.subjects[1]}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          BlocBuilder<InstructorBloc, InstructorState>(
            builder: (context, state) {
              if (state is InstructorLoadedState) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueGrey)),
                  child: ValueListenableBuilder(
                    valueListenable: state.rateNotifiers[instructor.id]!,
                    builder: (context, value, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Likes : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$value',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.thumb_up,
                            color: Colors.blueGrey,
                          )
                        ],
                      );
                    },
                  ),
                );
              }
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              ));
            },
          ),
        ]));
  }
}
