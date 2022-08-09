import 'package:flutter/material.dart';
import 'package:cicd_poc/data/todo_repo.dart';
import 'package:cicd_poc/domain/todo.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key, required this.repo}) : super(key: key);

  final TodoRepo repo;

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  final TextEditingController _todoCreationEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todos = widget.repo.getAllTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Base'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _todoCreationEditingController,
                ),
              ),
              IconButton(
                onPressed: () => _addTodo(_todoCreationEditingController.text),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].task),
                  trailing: IconButton(
                    onPressed: () => _removeTodo(todos[index]),
                    icon: const Icon(Icons.check_circle_outline_sharp),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addTodo(String task) {
    if (_todoCreationEditingController.text.isNotEmpty) {
      _todoCreationEditingController.clear();
      setState(() {
        var newTodo = Todo(task: task);
        widget.repo.addTodo(newTodo);
      });
    }
  }

  _removeTodo(Todo todoToRemove) {
    setState(() {
      widget.repo.removeTodo(todoToRemove);
    });
  }
}
