import 'package:example_dart/data/models/Person.dart';

class Teacher extends Person
{
  final List<String>? subjects;
  Teacher ({ required super.id,required super.name,this.subjects});
  factory Teacher.FromJson(Map<String, dynamic> json)
  {
    return new Teacher
    (
        id: json['id']??"" as String,
        name: json['name']??"" as String,
        subjects: json['subjects']??[] as List<String>
  );
  }
}