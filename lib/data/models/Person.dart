import 'package:example_dart/data/models/Student.dart';
import 'package:example_dart/data/models/Teacher.dart';

enum PersonType
{
  Student,
  Teacher
}
class Person
{
  final String id;
  final String name;
  Person({required this.id, required this.name});
  factory Person.Create({ required PersonType personType,
    required Map<String,dynamic> json})
  {
    if (personType==PersonType.Student)
      return Student.FromJson(json);
    else
      return Teacher.FromJson(json);
  }
}