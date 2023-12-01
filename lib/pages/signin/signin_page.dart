import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_go_router/providers/auth_state_provider.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('SignIn')),
      body: Center(
          child: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'email'),
            ),
            const SizedBox(
              height: 5,
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'password'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(authStateProvider.notifier)
                      .setAuthenticate(true);
                },
                child: const Text('LOGIN'))
          ],
        ),
      )),
    );
  }
}
