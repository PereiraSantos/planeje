import 'package:floor/floor.dart';

@Entity(tableName: 'question')
class Question {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'id_quiz')
  int? idQuiz;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'answer')
  bool? answer;

  @ignore
  bool? uniqueAnswer;

  Question({
    this.id,
    this.idQuiz,
    this.description,
    this.answer = false,
    this.uniqueAnswer,
  });

  void setIdQuiz(int? value) => idQuiz = id;
  void setDescription(String? value) => description = value;
  void setAnswer(bool? value) => answer = value;
  void setUniqueAnswer(bool? value) => uniqueAnswer = value;
}
