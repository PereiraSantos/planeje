import 'package:floor/floor.dart';
import 'package:planeje/suggestion/entities/suggestion.dart';

@dao
abstract class SuggestionDao {
  @Query('select * from suggestion')
  Future<List<Suggestion>?> findSuggestionAll();

  @Query('SELECT * FROM suggestion where description LIKE :text')
  Future<List<Suggestion>?> findSuggestionText(String text);

  @insert
  Future<int> insertSuggestion(Suggestion suggestion);

  @update
  Future<int?> updateSuggestion(Suggestion suggestion);

  @Query('delete FROM suggestion WHERE id = :id')
  Future<Suggestion?> deleteSuggestionById(int id);

  @Query('update suggestion set sortition = :sortition where id = :id')
  Future<Suggestion?> updateSortition(int id, bool sortition);
}
