import 'package:planeje/suggestion/datasource/database/suggestion_database.dart';
import 'package:planeje/suggestion/entities/suggestion.dart';
import 'package:planeje/utils/register.dart';
import 'package:planeje/utils/type_message.dart';

abstract class SuggestionFactory extends RegisterFactory {
  late Suggestion suggestion;
  Future<Suggestion?> updateSortition();
}

class InsertSuggestion implements SuggestionFactory {
  final SuggestionDatabaseFactory suggestionDatabase;

  InsertSuggestion(this.suggestionDatabase, this.message, this.suggestion);

  @override
  StatusNotification message;

  @override
  Suggestion suggestion;

  @override
  Future<int?> write() async {
    return await suggestionDatabase.insertSuggestion(suggestion);
  }

  @override
  Future<Suggestion?> updateSortition() async {
    return await suggestionDatabase.updateSortition(suggestion.id!, suggestion.sortition ?? false);
  }
}

class UpdateSuggestion implements SuggestionFactory {
  final SuggestionDatabaseFactory suggestionDatabase;

  UpdateSuggestion(this.suggestionDatabase, this.message, this.suggestion);

  @override
  StatusNotification message;

  @override
  Suggestion suggestion;

  @override
  Future<int?> write() async {
    return await suggestionDatabase.updateSuggestion(suggestion);
  }

  @override
  Future<Suggestion?> updateSortition() {
    throw UnimplementedError();
  }
}
