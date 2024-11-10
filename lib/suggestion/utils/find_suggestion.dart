import 'package:planeje/suggestion/datasource/database/suggestion_database.dart';
import 'package:planeje/suggestion/entities/suggestion.dart';
import 'package:planeje/utils/find.dart';

abstract class FindSuggestionFactory extends FindFactory {}

class GetSuggestion implements FindSuggestionFactory {
  SuggestionDatabaseFactory suggestionDatabase;

  GetSuggestion(this.suggestionDatabase);

  @override
  Future<List<Suggestion>?> getAll(String text) async {
    return await suggestionDatabase.findSuggestionAll(text);
  }

  @override
  Future<Suggestion?> getById(int id) async {
    return Suggestion();
  }
}
