import 'package:flutter/material.dart';

import '../../../entities/revision.dart';
import '../controller/revision_controller.dart';

class DialogDelete {
  static build(
    BuildContext context,
    RevisionListController revisionController,
    Revision revision,
  ) async {
    var r = await revisionController.getAnnotationByIdRevision(revision.id!) ?? [];
    if (r.isNotEmpty) {
      if (!context.mounted) return;
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "Existe anotação vinculada a \n${revision.description!}.\nNão pode ser excluida.",
              style: const TextStyle(color: Colors.black45, fontSize: 20),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                child: Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(
                        const BorderSide(width: 2, color: Color.fromARGB(80, 0, 0, 0)),
                      ),
                      foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
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
              style: const TextStyle(color: Colors.black45, fontSize: 20),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        var result = await revisionController.onClickDelete(revision.id!);
                        if (result && context.mounted) {
                          message(context, 'Removido com sucesso');
                          Navigator.pop(context, true);
                        }
                      },
                      style: ButtonStyle(
                        side: WidgetStateProperty.all(
                          const BorderSide(width: 2, color: Color.fromARGB(80, 0, 0, 0)),
                        ),
                        foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
                        side: WidgetStateProperty.all(
                          const BorderSide(width: 2, color: Color.fromARGB(80, 0, 0, 0)),
                        ),
                        foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
