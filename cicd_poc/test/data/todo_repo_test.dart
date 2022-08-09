import 'package:test/test.dart';
import 'package:cicd_poc/data/todo_repo.dart';
import 'package:cicd_poc/domain/todo.dart';

void main() {
  group('creating repo', () {
    test('when initialize repo then no exception', () {
      expect(() => TodoRepo(), returnsNormally);
    });
    test(
      'given new repo instance when get all todos then return empty list of todos',
      () {
        final testee = TodoRepo();
        final todos = testee.getAllTodos();
        expect(todos, equals([]));
      },
    );
  });
  group('adding todos', () {
    test('when adding todo then get all todos returns that todo', () {
      final testee = TodoRepo();
      var addedTodo = Todo(task: 'get test running');

      testee.addTodo(addedTodo);

      expect(testee.getAllTodos(), equals([addedTodo]));
    });
    test('when adding multiple todos then get all todos returns all todos', () {
      final testee = TodoRepo();

      testee.addTodo(Todo(task: 'first things first'));
      testee.addTodo(Todo(task: 'having second thoughts'));
      testee.addTodo(Todo(task: 'last but not least'));

      expect(testee.getAllTodos().length, 3);
    });
  });
  group('removing todos', () {
    test(
      'given repo with one todo when removing this todo then get all todos returns empty list',
      () {
        final testee = TodoRepo();
        final removedTodo = Todo(task: 'remove this todo');
        testee.addTodo(removedTodo);

        testee.removeTodo(removedTodo);

        expect(testee.getAllTodos(), equals([]));
      },
    );
    test(
        'given repo with multiple todos when removing one todo then get all todos returns all todos except removed one',
        () {
      final testee = _givenRepoWithMultipleTodos();
      final repoSize = testee.getAllTodos().length;
      final removedTodo = testee.getAllTodos()[1];

      testee.removeTodo(removedTodo);

      expect(testee.getAllTodos().length, repoSize - 1);
      expect(testee.getAllTodos(), isNot(contains(removedTodo)));
    });
    test(
        'given repo with multiple todos when removing one todo twice then get all todos returns all todos except removed one',
        () {
      final testee = _givenRepoWithMultipleTodos();
      final repoSize = testee.getAllTodos().length;
      final removedTodo = testee.getAllTodos()[1];

      testee.removeTodo(removedTodo);
      testee.removeTodo(removedTodo);

      expect(testee.getAllTodos().length, repoSize - 1);
      expect(testee.getAllTodos(), isNot(contains(removedTodo)));
    });
    test(
      'given repo with todo when removing non-existing todo then nothing changes',
      () {
        var existingTodo = Todo(task: 'exist before');
        final testee = TodoRepo()..addTodo(existingTodo);

        testee.removeTodo(Todo(task: 'non-existing todo'));

        expect(testee.getAllTodos(), equals([existingTodo]));
      },
    );
  });
}

TodoRepo _givenRepoWithMultipleTodos() => TodoRepo()
  ..addTodo(Todo(task: 'first things first'))
  ..addTodo(Todo(task: 'having second thoughts'))
  ..addTodo(Todo(task: 'last but not least'));
