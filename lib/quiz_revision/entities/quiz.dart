import 'package:floor/floor.dart';

@Entity(tableName: 'quiz')
class Quiz {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'topic')
  String? topic;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'sync')
  bool? sync;

  Quiz({
    this.id,
    this.topic,
    this.description,
    this.sync = true,
  });

  void setId(int? value) => id = value;
  void setTopic(String? value) => topic = value;
  void setDescription(String? value) => description = value;
  void setSync({bool? value}) => sync = value ?? false;

  static Quiz fromMapToObject(Map<String, dynamic> json) => Quiz(
        id: json['id'],
        topic: json['topic'],
        description: json['description'],
      );

  static Map<String, dynamic> fromObjectToMap(Quiz quiz) => {
        "topic": quiz.topic,
        "description": quiz.description,
      };
}
