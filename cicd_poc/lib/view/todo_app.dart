import 'package:flutter/material.dart';
import 'package:cicd_poc/data/todo_repo.dart';

import 'todos_page.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodosPage(
        repo: TodoRepo(),
      ),
    );
  }
}
