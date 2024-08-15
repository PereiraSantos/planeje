import 'package:floor/floor.dart';
import 'package:planeje/utils/cache/cache.dart';

@dao
abstract class CacheDao {
  @insert
  Future<int?> insertCache(Cache cache);

  @update
  Future<int?> updateCache(Cache cache);

  @Query('delete from cache where id = 1')
  Future<void> delete();

  @Query('select * from cache where id = 1')
  Future<List<Cache>?> getCache();
}
