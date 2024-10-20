import 'package:planeje/settings/datasource/database/setting_database.dart';
import 'package:planeje/settings/entities/settings.dart';

abstract class FindSettingFactory {
  Future<Settings?> findSettingByKey(String key);
}

class FindSetting implements FindSettingFactory {
  SettingDatabaseFactory settingDatabaseDataSource;

  FindSetting(this.settingDatabaseDataSource);

  @override
  Future<Settings?> findSettingByKey(String key) async {
    return await settingDatabaseDataSource.findSettingByKey(key);
  }
}
