import 'package:floor/floor.dart';

// ignore: constant_identifier_names
enum TypeQuiz { Adicionar, Atualizar }

@Entity(tableName: 'quiz')
class Quiz {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'topic')
  String? topic;

  @ColumnInfo(name: 'description')
  String? description;

  @ignore
  TypeQuiz? _type;

  @ignore
  String? _message;

  Quiz({this.id, this.topic, this.description});

  void setId(int? value) => id = value;
  void setTopic(String? value) => topic = value;
  void setDescription(String? value) => description = value;

  void setTypeQuiz(TypeQuiz value) {
    _type = value;
    _message = _type!.index == TypeQuiz.Adicionar.index ? 'Registrado com sucesso' : 'Atualizado com sucesso';
  }

  TypeQuiz? get getTypeQuiz => _type;

  String get message => _message ?? '';
}
