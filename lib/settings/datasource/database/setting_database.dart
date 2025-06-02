import 'package:planeje/database/app_database.dart';
import '../../entities/settings.dart';

abstract class SettingDatabaseFactory {
  Future<int?> updateSetting(Settings settings);
  Future<int?> insertSetting(Settings settings);
  Future<Settings?> findSettingByKey(String key);
}

class SettingDatabase implements SettingDatabaseFactory {
  @override
  Future<int?> insertSetting(Settings settings) async {
    final database = await getInstance();
    return await database.settingDao.insertSetting(settings);
  }

  @override
  Future<int?> updateSetting(Settings settings) async {
    final database = await getInstance();
    return await database.settingDao.updateSetting(settings);
  }

  @override
  Future<Settings?> findSettingByKey(String key) async {
    final database = await getInstance();
    return await database.settingDao.findSettingByKey(key);
  }
}
