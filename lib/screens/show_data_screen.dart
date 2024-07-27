import 'package:flutter/material.dart';
import 'package:show_data/screens/home.dart';
import '../models/instructor.dart';

class ShowDataScreen extends StatefulWidget {
  final Instructor instructor;
  ShowDataScreen({super.key, required this.instructor});

  @override
  State<ShowDataScreen> createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
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
            backgroundImage: NetworkImage(widget.instructor.image),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            widget.instructor.name,
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
                  'Instructor name : ${widget.instructor.name}',
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
                  '1. ${widget.instructor.subjects[0]}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  '2. ${widget.instructor.subjects[1]}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueGrey)),
            child: ValueListenableBuilder(
              valueListenable: rateNotifiers[widget.instructor.id]!,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Likes : ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          ),
        ]));
  }
}
