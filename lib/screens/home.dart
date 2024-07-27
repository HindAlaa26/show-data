import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:show_data/models/instructor.dart';
import 'package:show_data/screens/show_data_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Map<int, ValueNotifier<int>> rateNotifiers = {};

class _HomePageState extends State<HomePage> {
  List<Instructor> instructors = [];
  bool isLoading = false;

  @override
  void initState() {
    initList();
    super.initState();
  }

  void initList() async {
    var result = await rootBundle.loadString('assets/data.json');
    var response = jsonDecode(result);
    instructors = List<Instructor>.from(
        response['data'].map((e) => Instructor.fromJson(e)).toList());

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
      body: ListView(
        children: instructors
            .map((instructor) => Container(
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
                              image: NetworkImage(instructor.image),
                              fit: BoxFit.fill)),
                    ),
                    title: Text(instructor.name),
                    subtitle: Text(
                        "${instructor.subjects[0]} , ${instructor.subjects[1]}"),
                    trailing: likes(rateNotifiers[instructor.id]!),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowDataScreen(
                              instructor: instructor,
                            ),
                          ));
                    },
                  ),
                ))
            .toList(),
      ),
    );
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
