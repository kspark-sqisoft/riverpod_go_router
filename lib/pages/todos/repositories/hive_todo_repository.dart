import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_go_router/pages/todos/models/todo.dart';
import 'package:riverpod_go_router/pages/todos/repositories/todo_repository.dart';

class HiveTodoRepository extends TodoRepository {
  final Box todoBox = Hive.box('todos');

  @override
  Future<List<Todo>> getTodos() async {
    try {
      if (todoBox.length == 0) return <Todo>[];
      return [
        for (final todo in todoBox.values)
          Todo.fromJson(Map<String, dynamic>.from(todo))
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addTodo({required Todo todo}) async {
    try {
      await todoBox.put(todo.id, todo.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTodo({required String id, required String desc}) async {
    try {
      final todoMap = todoBox.get(id);
      todoMap['desc'] = desc;
      await todoBox.put(id, todoMap);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleTodo({required String id}) async {
    try {
      final todoMap = todoBox.get(id);
      todoMap['completed'] = !todoMap['completed'];
      await todoBox.put(id, todoMap);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTodo({required String id}) async {
    try {
      await todoBox.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}
