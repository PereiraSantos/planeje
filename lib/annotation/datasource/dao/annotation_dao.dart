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

  @Query('select * from annotation where id_external = :idExternal')
  Future<Annotation?> findAnnotationByIdExternal(int idExternal);

  @Query('update annotation set disable = 1 where id = :id')
  Future<void> disable(int id);

  @Query('update annotation set disable = 1 where id_revision = :idRevision')
  Future<void> disableByIdRevision(int idRevision);

  @Query('select * from  annotation where id_revision = :idRevision and disable = 0')
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision);

  @Query('select * from  annotation where and disable = 0')
  Future<List<Annotation>?> getAnnotationAll();

  @Query('select * from annotation where sync = 0 where disable = 0')
  Future<List<Annotation>?> findAnnotationSync();

  @update
  Future<void> updateAnnotationList(List<Annotation> annotation);
}
