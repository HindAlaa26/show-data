class Instructor {
  late int id;
  late String name;
  late List<dynamic> subjects;
  late String image;

  Instructor.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    subjects = data['subjects'];
    image = data['image'];
  }
}
