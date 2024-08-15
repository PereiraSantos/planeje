import 'package:planeje/utils/cache/cache.dart';
import 'package:planeje/utils/cache/database_cache.dart';
import 'package:planeje/utils/type_message.dart';

abstract class IRegisterCache {
  Future<int?> writeLearn();
  late Cache cache;
  late StatusNotification message;
}

class SaveCache implements IRegisterCache {
  IDataBaseCache dataBaseCache;

  SaveCache(this.dataBaseCache, this.cache, this.message);

  @override
  Cache cache;

  @override
  StatusNotification message;

  @override
  Future<int?> writeLearn() async {
    return dataBaseCache.insertCache(cache);
  }
}

class UpdateCache implements IRegisterCache {
  IDataBaseCache dataBaseCache;

  UpdateCache(this.dataBaseCache, this.cache, this.message);

  @override
  Cache cache;

  @override
  StatusNotification message;

  @override
  Future<int?> writeLearn() async {
    return dataBaseCache.updateCache(cache);
  }
}
