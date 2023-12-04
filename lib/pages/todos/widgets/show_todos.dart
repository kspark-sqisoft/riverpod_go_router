import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_go_router/main.dart';
import 'package:riverpod_go_router/pages/todos/models/todo.dart';
import 'package:riverpod_go_router/pages/todos/providers/todo_filter_provider.dart';
import 'package:riverpod_go_router/pages/todos/providers/todo_item_provider.dart';
import 'package:riverpod_go_router/pages/todos/providers/todo_list_provider.dart';
import 'package:riverpod_go_router/pages/todos/providers/todo_search_provider.dart';
import 'package:riverpod_go_router/pages/todos/widgets/todo_item.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

class ShowTodos extends ConsumerStatefulWidget {
  const ShowTodos({super.key});

  @override
  ConsumerState<ShowTodos> createState() => _ShowTodosState();
}

class _ShowTodosState extends ConsumerState<ShowTodos> {
  Widget prevTodosWidget = const SizedBox.shrink();

  List<Todo> filterTodos(List<Todo> allTodos) {
    final filter = ref.watch(todoFilterProvider);
    final search = ref.watch(todoSearchProvider);

    List<Todo> tempTodos;

    tempTodos = switch (filter) {
      Filter.active => allTodos.where((todo) => !todo.completed).toList(),
      Filter.completed => allTodos.where((todo) => todo.completed).toList(),
      Filter.all => allTodos,
    };

    if (search.isNotEmpty) {
      tempTodos = tempTodos
          .where(
              (todo) => todo.desc.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }

    return tempTodos;
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<Todo>>>(todoListProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) {
          if (!next.isLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Error',
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    e.toString(),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          }
        },
      );
    });

    ref.listen(changeRouteProvider, (p, n) {
      if (n.routeType == ChangeRouteType.going && n.routeName == '/todos') {
        _scrollController.animateTo(0,
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
    });

    final todoListState = ref.watch(todoListProvider);

    return todoListState.when(
      skipError: true,
      data: (List<Todo> allTodos) {
        if (allTodos.isEmpty) {
          prevTodosWidget = const Center(
            child: Text(
              'Enter some todo',
              style: TextStyle(fontSize: 20),
            ),
          );
          return prevTodosWidget;
        }

        final filteredTodos = filterTodos(allTodos);

        prevTodosWidget = ScrollsToTop(
          onScrollsToTop: (ScrollsToTopEvent event) async {
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          },
          child: ListView.separated(
            controller: _scrollController,
            itemCount: filteredTodos.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(color: Colors.grey);
            },
            itemBuilder: (BuildContext context, int index) {
              final todo = filteredTodos[index];
              return ProviderScope(
                overrides: [
                  todoItemProvider.overrideWithValue(todo),
                ],
                child: const TodoItem(),
              );
            },
          ),
        );
        return prevTodosWidget;
      },
      error: (error, _) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  ref.invalidate(todoListProvider);
                },
                child: const Text(
                  'Please Retry!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
      loading: () {
        return prevTodosWidget;
      },
    );
  }
}
