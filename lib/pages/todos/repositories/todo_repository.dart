import 'package:riverpod_go_router/pages/todos/models/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<void> addTodo({required Todo todo});
  Future<void> editTodo({required String id, required String desc});
  Future<void> toggleTodo({required String id});
  Future<void> removeTodo({required String id});
}
