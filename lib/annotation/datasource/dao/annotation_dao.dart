import 'package:floor/floor.dart';
import 'package:planeje/annotation/entities/annotation.dart';

@dao
abstract class AnnotationDao {
  @insert
  Future<int?> insertAnnotation(Annotation annotationEntity);

  @update
  Future<int?> updateAnnotation(Annotation annotationEntity);

  @Query('delete from annotation where id = :id')
  Future<void> delete(int id);

  @Query('delete from annotation where id_revision = :idRevision')
  Future<void> deleteByIdRevision(int idRevision);

  @Query('select * from  annotation where id_revision = :idRevision')
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision);
}
