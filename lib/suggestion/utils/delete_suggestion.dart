import 'package:planeje/suggestion/datasource/database/suggestion_database.dart';
import 'package:planeje/suggestion/entities/suggestion.dart';
import 'package:planeje/utils/delete.dart';

abstract class DeleteSuggestionFactory extends DeleteFactory {}

class DeleteSugestion implements DeleteSuggestionFactory {
  SuggestionDatabaseFactory suggestionDatabase;

  DeleteSugestion(this.suggestionDatabase);

  @override
  Future<Suggestion?> deleteById(int id) async {
    return await suggestionDatabase.deleteSuggestionById(id);
  }
}
