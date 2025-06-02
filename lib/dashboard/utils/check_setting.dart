import 'package:planeje/settings/datasource/database/setting_database.dart';
import 'package:planeje/settings/entities/settings.dart';
import 'package:planeje/settings/utils/find_setting.dart';
import 'package:planeje/settings/utils/register_setting.dart';

class CheckSetting {
  void checkRealize() async {
    Settings? setting = await FindSetting(SettingDatabase()).findSettingByKey('realize');
    if (setting == null) insertSettingRealizeIsNull();
  }

  void checkNext() async {
    Settings? setting = await FindSetting(SettingDatabase()).findSettingByKey('next');
    if (setting == null) insertSettingnextIsNull();
  }

  void insertSettingRealizeIsNull() => InsertSetting(SettingDatabase(), Settings(key: 'realize', value: '3')).write();

  void insertSettingnextIsNull() => InsertSetting(SettingDatabase(), Settings(key: 'next', value: '3')).write();
}
