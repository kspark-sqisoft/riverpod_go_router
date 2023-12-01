import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_go_router/pages/todos/widgets/filter_todo.dart';
import 'package:riverpod_go_router/pages/todos/widgets/new_todo.dart';
import 'package:riverpod_go_router/pages/todos/widgets/search_todo.dart';
import 'package:riverpod_go_router/pages/todos/widgets/show_todos.dart';
import 'package:riverpod_go_router/pages/todos/widgets/todo_header.dart';
import 'package:riverpod_go_router/providers/auth_state_provider.dart';
import 'package:riverpod_go_router/providers/theme_provider.dart';
import 'package:riverpod_go_router/router/route_names.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TodosPage extends ConsumerStatefulWidget {
  const TodosPage({super.key});

  @override
  ConsumerState<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends ConsumerState<TodosPage> {
  @override
  void initState() {
    print('TodosPage initState');
    super.initState();
  }

  @override
  void dispose() {
    print('TodosPage dispose');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TodoHeader(),
              NewTodo(),
              SizedBox(height: 20),
              SearchTodo(),
              SizedBox(height: 10),
              FilterTodo(),
              SizedBox(height: 10),
              Expanded(child: ShowTodos()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await ref.watch(authStateProvider.notifier).setAuthenticate(false);
          },
          icon: const Icon(Icons.exit_to_app),
          label: const Text('Sign Out'),
        ),
      ),
    );
  }
}
