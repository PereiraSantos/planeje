import 'package:floor/floor.dart';

@Entity(tableName: 'cache')
class Cache {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'id')
  int id = 1;

  @ColumnInfo(name: 'hash')
  String hash;

  Cache(this.id, this.hash);

  void setHash(String value) => hash = value;
}
