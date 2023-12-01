import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_go_router/pages/products/products_page.dart';

class ScaffoldWithNavBarStateFullShell extends ConsumerStatefulWidget {
  const ScaffoldWithNavBarStateFullShell(
      {super.key, required this.statefulNavigationShell});
  final StatefulNavigationShell statefulNavigationShell;

  @override
  ConsumerState<ScaffoldWithNavBarStateFullShell> createState() =>
      _ScaffoldWithNavBarStateFullShellState();
}

class _ScaffoldWithNavBarStateFullShellState
    extends ConsumerState<ScaffoldWithNavBarStateFullShell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.statefulNavigationShell,
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
        currentIndex: widget.statefulNavigationShell.currentIndex,
        onTap: (int index) async {
          _onTap(context, index);
        },
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    widget.statefulNavigationShell.goBranch(
      index,
      initialLocation: index == widget.statefulNavigationShell.currentIndex,
    );
  }
}
