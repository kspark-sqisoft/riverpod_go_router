import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_go_router/pages/todos/models/todo.dart';

part 'todo_filter_provider.g.dart';

@riverpod
class TodoFilter extends _$TodoFilter {
  @override
  Filter build() {
    return Filter.all;
  }

  void changeFilter(Filter newFilter) {
    state = newFilter;
  }
}
