import 'package:floor/floor.dart';
import 'package:planeje/annotation/entities/annotation.dart';

@dao
abstract class AnnotationDao {
  @insert
  Future<int?> insertAnnotation(Annotation annotationEntity);

  @insert
  Future<List<int>> insertAnnotationList(List<Annotation> annotationEntity);

  @update
  Future<int?> updateAnnotation(Annotation annotationEntity);

  @Query('select count(*) from annotation where id_external = :idExternal')
  Future<int?> isRegistration(int idExternal);

  @Query('delete from annotation where id = :id')
  Future<void> delete(int id);

  @Query('delete from annotation where id_revision = :idRevision')
  Future<void> deleteByIdRevision(int idRevision);

  @Query('select * from  annotation where id_revision = :idRevision')
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision);

  @Query('select * from  annotation')
  Future<List<Annotation>?> getAnnotationAll();

  @Query('select * from annotation where sync = 0')
  Future<List<Annotation>?> findAnnotationSync();

  @update
  Future<void> updateAnnotationList(List<Annotation> annotation);
}
