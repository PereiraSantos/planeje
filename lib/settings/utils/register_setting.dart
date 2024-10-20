import 'package:planeje/settings/datasource/database/setting_database.dart';
import 'package:planeje/settings/entities/settings.dart';
import 'package:planeje/utils/register.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RegisterSettingFactory extends RegisterFactory {
  late Settings settings;
}

class InsertSetting implements RegisterSettingFactory {
  SettingDatabaseFactory settingDatabaseDataSource;

  InsertSetting(this.settingDatabaseDataSource, this.settings, this.message);

  @override
  Future<int?> write() async {
    return await settingDatabaseDataSource.insertSetting(settings);
  }

  @override
  Settings settings;

  @override
  StatusNotification message;
}

class UpdateSetting implements RegisterSettingFactory {
  SettingDatabaseFactory settingDatabaseDataSource;

  UpdateSetting(this.settingDatabaseDataSource, this.settings, this.message);

  @override
  Future<int?> write() async {
    return await settingDatabaseDataSource.updateSetting(settings);
  }

  @override
  Settings settings;

  @override
  StatusNotification message;
}
