import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cicd_poc/main.dart' as cicd_poc;
import 'package:cicd_poc/view/todos_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'smoke test: add, view and remove todo',
    (WidgetTester tester) async {
      await _launchApp(tester);
      expect(find.byType(TodosPage), findsOneWidget);

      var todoTask = 'first todo';
      await _addTodo(tester, todoTask);
      expect(find.text(todoTask), findsOneWidget);

      await _removeTodo(tester);
      expect(find.text(todoTask), findsNothing);
    },
  );
}

Future<void> _launchApp(WidgetTester tester) async {
  cicd_poc.main();
  await tester.pumpAndSettle();
}

Future<void> _addTodo(WidgetTester tester, String task) async {
  await tester.enterText(find.byType(TextField), task);
  await tester.tap(find.widgetWithIcon(IconButton, Icons.add));
  await tester.pump();
}

Future<void> _removeTodo(WidgetTester tester) async {
  await tester.tap(
    find.widgetWithIcon(IconButton, Icons.check_circle_outline_sharp).first,
  );
  await tester.pump();
}
