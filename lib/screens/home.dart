import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_data/bloc/instructor_bloc.dart';
import 'package:show_data/bloc/instructor_event.dart';
import 'package:show_data/bloc/instructor_states.dart';
import 'package:show_data/models/instructor.dart';
import 'package:show_data/screens/show_data_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Map<int, ValueNotifier<int>> rateNotifiers = {};

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<InstructorBloc>().add(LoadInstructorEvent());
  }

  void initList(List<Instructor> instructors) {
    for (var instructor in instructors) {
      rateNotifiers[instructor.id] = ValueNotifier(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Instructors Data",
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<InstructorBloc, InstructorState>(
          builder: (context, state) {
            if (state is InstructorLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              ));
            }
            if (state is InstructorLoadedState) {
              initList(state.instructors);
              return ListView.builder(
                itemCount: state.instructors.length,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade500, spreadRadius: 3)
                      ]),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Container(
                      height: 100,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          image: DecorationImage(
                              image:
                                  NetworkImage(state.instructors[index].image),
                              fit: BoxFit.fill)),
                    ),
                    title: Text(state.instructors[index].name),
                    subtitle: Text(
                        "${state.instructors[index].subjects[0]} , ${state.instructors[index].subjects[1]}"),
                    trailing:
                        likes(rateNotifiers[state.instructors[index].id]!),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowDataScreen(
                              instructor: state.instructors[index],
                            ),
                          ));
                    },
                  ),
                ),
              );
            }
            if (state is InstructorErrorState) {
              print(state.error);
              return Center(child: Text("Instructors: ${state.error}"));
            }
            return const SizedBox.shrink();
          },
        ));
  }
}

Widget likes(ValueNotifier<int> rateNotifier) {
  return Column(
    children: [
      Expanded(
        child: CircleAvatar(
          child: ValueListenableBuilder(
            valueListenable: rateNotifier,
            builder: (context, value, _) {
              return Text("$value");
            },
          ),
        ),
      ),
      const SizedBox(height: 5),
      Expanded(
        child: IconButton(
            onPressed: () {
              rateNotifier.value++;
            },
            icon: const Icon(
              Icons.thumb_up,
              color: Colors.blueGrey,
            )),
      )
    ],
  );
}
