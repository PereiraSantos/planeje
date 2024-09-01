import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/utils/delete_revision.dart';

import '../../../entities/revision.dart';

class DialogDelete {
  static build(
    BuildContext context,
    Revision revision,
  ) async {
    List<Annotation> result =
        await GetAnnotation(AnnotationDatabase()).getAnnotationWidthIdRevision(revision.id!) ?? [];

    if (result.isNotEmpty) {
      if (!context.mounted) return;
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "Existe anotação vinculada a \n${revision.description!}.\nNão pode ser excluida.",
              style: const TextStyle(color: Colors.black45, fontSize: 18),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                child: Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 40),
                      ),
                      textStyle: WidgetStateProperty.all(
                        const TextStyle(fontSize: 18),
                      ),
                    ),
                    child: const Text("Ok"),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      if (!context.mounted) return;
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "Deseja excluir? \n${revision.description!}",
              style: const TextStyle(color: Colors.black45, fontSize: 18),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        var result =
                            await DeleteRevision(RevisionDatabaseDataSource()).deleteById(revision.id!);

                        if (result != null && context.mounted) {
                          message(context, 'Removido com sucesso');
                          Navigator.pop(context, true);
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
                        ),
                        textStyle: WidgetStateProperty.all(
                          const TextStyle(fontSize: 18),
                        ),
                      ),
                      child: const Text("SIM"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
                        ),
                        textStyle: WidgetStateProperty.all(
                          const TextStyle(fontSize: 18),
                        ),
                      ),
                      child: const Text("NÃO"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }
  }

  static void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
