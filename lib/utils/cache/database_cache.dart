import 'package:planeje/database/app_database.dart';
import 'package:planeje/utils/cache/cache.dart';

abstract class IDataBaseCache {
  Future<int?> insertCache(Cache cache);
  Future<List<Cache>?> getCache();
  Future<int?> updateCache(Cache cache);
  Future<void> deleteCache();
}

class DatabaseCache implements IDataBaseCache {
  @override
  Future<List<Cache>?> getCache() async {
    final database = await getInstance();
    return await database.cacheDao.getCache();
  }

  @override
  Future<int?> insertCache(Cache cache) async {
    final database = await getInstance();
    return await database.cacheDao.insertCache(cache);
  }

  @override
  Future<int?> updateCache(Cache cache) async {
    final database = await getInstance();
    return await database.cacheDao.updateCache(cache);
  }

  @override
  Future<void> deleteCache() async {
    final database = await getInstance();
    return await database.cacheDao.delete();
  }
}
