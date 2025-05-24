import 'package:floor/floor.dart';

@Entity(tableName: 'quiz')
class Quiz {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'id_external')
  int? idExternal;

  @ColumnInfo(name: 'topic')
  String? topic;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'sync')
  bool? sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  Quiz({
    this.id,
    this.idExternal,
    this.topic,
    this.description,
    this.sync = true,
    this.disable = false,
  });

  void setId(int? value) => id = value;
  void setIdExternal(int? value) => idExternal = value;
  void setTopic(String? value) => topic = value;
  void setDescription(String? value) => description = value;
  void setSync({bool? value}) => sync = value ?? false;
  void setDisable(bool value) => disable = value;

  static Quiz fromMapToObject(Map<String, dynamic> json) => Quiz(
        idExternal: json['id'],
        topic: json['topic'],
        description: json['description'],
      );

  static Map<String, dynamic> fromObjectToMap(Quiz quiz) => {
        "id": quiz.idExternal,
        "topic": quiz.topic,
        "description": quiz.description,
      };
}
