import 'package:floor/floor.dart';

@Entity(tableName: 'learn')
class Learn {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'description')
  String? description;

  Learn({this.id, this.description});

  void setId(int? value) => id = value;
  void setDescription(String? value) => description = value;
}
