import 'package:cicd_poc/domain/todo.dart';

class TodoRepo {
  final List<Todo> _todos = [];

  getAllTodos() => _todos;

  void addTodo(Todo newTodo) => _todos.add(newTodo);

  void removeTodo(Todo removedTodo) => _todos.remove(removedTodo);
}
