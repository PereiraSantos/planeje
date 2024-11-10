import 'package:floor/floor.dart';

@Entity(tableName: 'suggestion')
class Suggestion {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'id_learn')
  int? idLearn;

  @ColumnInfo(name: 'sortition')
  bool? sortition;

  @ignore
  bool select;

  Suggestion({this.id, this.description, this.idLearn, this.sortition, this.select = false});

  void setId(int? value) => id = value;
  void setDescription(String? value) => description = value;
  void setIdLearn(int? value) => idLearn = value;
}
