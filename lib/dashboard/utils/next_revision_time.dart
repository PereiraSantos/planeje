import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/settings/datasource/database/setting_database.dart';
import 'package:planeje/settings/entities/settings.dart';
import 'package:planeje/settings/utils/find_setting.dart';

class NetRevisionTime {
  NetRevisionTime(this.isBefore);

  final bool isBefore;

  Future<List<RevisionTime>?> getNextRevision(String key) async {
    Settings? settings = await FindSetting(SettingDatabaseDataSource()).findSettingByKey(key);

    return await GetRevision(RevisionDatabaseDataSource())
        .findRevisionByDescription('', isBefore, limit: settings != null ? int.parse(settings.value!) : null);
  }
}
