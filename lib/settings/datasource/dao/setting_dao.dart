import 'package:floor/floor.dart';
import 'package:planeje/settings/entities/settings.dart';

@dao
abstract class SettingDao {
  @Query('select * from setting where keystone = :key')
  Future<Settings?> findSettingByKey(String key);

  @insert
  Future<int> insertSetting(Settings settings);

  @update
  Future<int?> updateSetting(Settings settings);
}
