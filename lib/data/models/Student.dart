import 'package:example_dart/data/models/Person.dart';
class Student extends Person
{
  final double? math;
  final double? phic;
  final double? chem;
  Student({required super.id,
    required super.name,
    this.math,  this.phic, this.chem
  });
  Student copyTo({String? id, String? name,
    double? math, double? phic, double? chem})
  {
    return new Student(
        id: id??this.id,
        name: name??this.name,
        math: math??this.math,
        phic: phic??this.phic,
        chem: chem??this.chem
    );
  }
  factory Student.FromJson(Map<String,dynamic> json)
  {
    return new Student(
    id:  json['id']??"" as String,
    name: json['name']??"" as String ,
    math: (json['math']as num).toDouble(),
    phic: (json['phic'] as num).toDouble(),
    chem: (json['chem'] as num).toDouble(),
  )  ;
  }
}