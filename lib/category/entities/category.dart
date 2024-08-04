import 'package:floor/floor.dart';

@Entity(tableName: 'category')
class Category {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'description')
  String? description;

  @ignore
  bool select;

  Category({this.id, this.description, this.select = false});

  void setId(int? value) => id = value;
  void setDescription(String? value) => description = value;
}
