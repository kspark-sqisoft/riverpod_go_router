import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_go_router/pages/todos/providers/todo_search_provider.dart';

class SearchTodo extends ConsumerStatefulWidget {
  const SearchTodo({super.key});

  @override
  ConsumerState<SearchTodo> createState() => _SearchTodoState();
}

class _SearchTodoState extends ConsumerState<SearchTodo> {
  final debounce = Debounce(milliseconds: 1000);

  @override
  void dispose() {
    debounce.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Search todos...',
        border: InputBorder.none,
        filled: true,
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (String? newSearchTerm) {
        if (newSearchTerm != null) {
          debounce.run(() {
            ref.read(todoSearchProvider.notifier).setSearchTerm(newSearchTerm);
          });
        }
      },
    );
  }
}

class Debounce {
  final int milliseconds;
  Debounce({
    this.milliseconds = 500,
  });

  Timer? _timer;

  void run(VoidCallback action) {
    close();

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void close() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }
}
