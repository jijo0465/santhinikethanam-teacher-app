import 'package:teacher_app/models/grade.dart';

class Teacher {
  int id;
  String _teacherid;
  int age;
  double rewards;
  Grade grade;
  String name;
  String parentName;
  String classTeacher;
  String bloodGroup;
  String dateOfBirth;
  String photoUrl;

  get teacherId => _teacherid;

  Teacher(
      this.id,
      this._teacherid,
      this.name,
      //this.parentName,
      //this.classTeacher,
//      this.grade,
//      this.dateOfBirth,
//      this.bloodGroup,
//      this.photoUrl
      );

  factory Teacher.fromMap(Map<String, dynamic> value) {
    // print(value.toString());
    Teacher teacher = Teacher(
      //value['id'],
        value['id'],
        value['teacherId'],
        value['name'],
//        Grade.fromMap(value['grade'])
      //value['parentName'],
      //value['classTeacher'],
      //value['grade'],
//        value['date_of_birth'],
//        value['blood_group'],
//        value['photo_url']
    );
    //student.studentId = student.id;
    // student.id=value['id'];
    // student.id=value['student_id'];
    // student.name=value['name'];
    // //student.parentName=value['parentName'];
    // //student.classTeacher=value['classTeacher'];
    // //student.grade=value['grade'];
    // student.dateOfBirth=value['date_of_birth'];
    // student.bloodGroup=value['blood_group'];
    // //student.age=value['age'];
    // //student.rewards=value['rewards'];
    // student.photoUrl=value['photo_url'];
    return teacher;
  }
  Map toJson() => {
    'name': name,
    'grade': grade,
  };
}
