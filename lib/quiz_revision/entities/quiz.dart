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

  Quiz({this.id, this.topic, this.description});

  void setId(int? value) => id = value;
  void setTopic(String? value) => topic = value;
  void setDescription(String? value) => description = value;
}
