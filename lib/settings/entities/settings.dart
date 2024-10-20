import 'package:floor/floor.dart';

@Entity(tableName: 'setting')
class Settings {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'keystone')
  String? key;

  @ColumnInfo(name: 'value')
  String? value;

  Settings({this.id, this.key, this.value});

  set setId(int value) => id = value;
  set setKey(String value) => key = value;
  set setValue(String valueArgs) => value = valueArgs;
}
