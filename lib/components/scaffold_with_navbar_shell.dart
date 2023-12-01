import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_go_router/router/route_names.dart';

class ScaffoldWithNavbarShell extends StatefulWidget {
  const ScaffoldWithNavbarShell({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<ScaffoldWithNavbarShell> createState() =>
      _ScaffoldWithNavbarShellState();
}

class _ScaffoldWithNavbarShellState extends State<ScaffoldWithNavbarShell> {
  int currentIndex = 0;

  @override
  void initState() {
    print('ScaffoldWithNavbarShell initState');
    super.initState();
  }

  @override
  void dispose() {
    print('ScaffoldWithNavbarShell dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Media',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today_rounded),
            label: 'Todo',
          ),
        ],
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (int index) {
          _onTap(index);
        },
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    switch (index) {
      case 0:
        context.goNamed(RouteNames.weather);
      case 1:
        context.goNamed(RouteNames.medias);
      case 2:
        context.goNamed(RouteNames.products);
      case 3:
        context.goNamed(RouteNames.todos);
    }
  }
}
