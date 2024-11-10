import 'package:planeje/database/app_database.dart';
import 'package:planeje/suggestion/entities/suggestion.dart';

abstract class SuggestionDatabaseFactory {
  Future<int?> updateSuggestion(Suggestion suggestion);
  Future<int?> insertSuggestion(Suggestion suggestion);
  Future<List<Suggestion>?> findSuggestionAll(String text);
  Future<Suggestion?> deleteSuggestionById(int id);
  Future<Suggestion?> updateSortition(int id, bool sortition);
}

class SuggestionDatabaseDataSource implements SuggestionDatabaseFactory {
  @override
  Future<int?> insertSuggestion(Suggestion suggestion) async {
    final database = await getInstance();
    return await database.suggestionDao.insertSuggestion(suggestion);
  }

  @override
  Future<int?> updateSuggestion(Suggestion suggestion) async {
    final database = await getInstance();
    return await database.suggestionDao.updateSuggestion(suggestion);
  }

  @override
  Future<List<Suggestion>?> findSuggestionAll(String text) async {
    final database = await getInstance();
    if (text != '') return await database.suggestionDao.findSuggestionText('%$text%');
    return await database.suggestionDao.findSuggestionAll();
  }

  @override
  Future<Suggestion?> deleteSuggestionById(int id) async {
    final database = await getInstance();
    return await database.suggestionDao.deleteSuggestionById(id);
  }

  @override
  Future<Suggestion?> updateSortition(int id, bool sortition) async {
    final database = await getInstance();
    return await database.suggestionDao.updateSortition(id, sortition);
  }
}
