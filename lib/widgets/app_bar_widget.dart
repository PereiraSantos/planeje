import 'package:flutter/material.dart';
import 'button_custon.dart';

// ignore: must_be_immutable
class AppBarWidget extends StatelessWidget {
  AppBarWidget({
    super.key,
    required this.callbackHome,
    required this.callbackReviser,
    required this.callbackAnnotation,
    required this.callbackAdd,
    required this.callbackFilter,
    required this.callBackQuiz,
    this.colorHome = Colors.black12,
    this.colorReviser = Colors.black12,
    this.colorAnnotation = Colors.black12,
    this.colorQuiz = Colors.black12,
    this.showAction = true,
    this.quantity = 0,
  });

  final Function callbackHome;
  final Function callbackReviser;
  final Function callbackAnnotation;
  final Function callBackQuiz;
  final Function callbackAdd;
  final Function callbackFilter;

  Color colorHome;
  Color colorReviser;
  Color colorAnnotation;
  Color colorQuiz;
  bool showAction;
  int quantity;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xffffffff),
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => callbackHome(),
            child: ButtonCuston(
              color: colorHome,
              width: 30,
              child: const Icon(
                Icons.home,
                color: Colors.black54,
                size: 20,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => callbackReviser(),
            child: ButtonCuston(
              color: colorReviser,
              width: MediaQuery.of(context).size.width * 0.2,
              margin: const EdgeInsets.only(left: 05),
              child: const Text(
                "Revisão",
                style: TextStyle(
                    fontSize: 13, color: Color.fromARGB(137, 10, 5, 5), fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => callbackAnnotation(),
            child: ButtonCuston(
              color: colorAnnotation,
              width: MediaQuery.of(context).size.width * 0.2,
              margin: const EdgeInsets.only(left: 05),
              child: const Text(
                "Anotação",
                style: TextStyle(
                    fontSize: 13, color: Color.fromARGB(137, 10, 5, 5), fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => callBackQuiz(),
            child: ButtonCuston(
              color: colorQuiz,
              width: MediaQuery.of(context).size.width * 0.2,
              margin: const EdgeInsets.only(left: 05),
              child: const Text(
                "Quiz",
                style: TextStyle(
                    fontSize: 13, color: Color.fromARGB(137, 10, 5, 5), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Visibility(
          visible: showAction,
          child: SizedBox(
            width: 30,
            child: IconButton(
              onPressed: () async => await callbackAdd(),
              icon: const Icon(
                Icons.add,
                color: Colors.black54,
                size: 20,
              ),
            ),
          ),
        ),

        /*  Visibility(
          visible: showAction,
          child: IconButton(
            onPressed: () => callbackFilter(),
            icon: const Icon(
              Icons.filter_alt_rounded,
              color: Colors.black54,
              size: 20,
            ),
          ),
        ),*/
        Visibility(
          visible: !showAction,
          child: SizedBox(
            width: 35,
            child: IconButton(
              onPressed: null,
              icon: Badge(
                label: Text("$quantity"),
                isLabelVisible: quantity > 0 ? true : false,
                child: const Icon(
                  Icons.notifications,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
