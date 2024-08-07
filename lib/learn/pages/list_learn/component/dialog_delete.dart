import 'package:flutter/material.dart';
import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/learn/utils/delete_learn.dart';

class DialogDelete {
  static build(BuildContext context, Learn learn) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Deseja excluir? \n${learn.description!}",
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
                      var result = await DeleteLearn(LearnDatabase()).deleteLearnById(learn.id!);

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

  static void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
