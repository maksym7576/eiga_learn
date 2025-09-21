import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppNavigator extends HookConsumerWidget {
  final Widget child;

  const AppNavigator({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    int selectedIndex = 0;
    if (location == '/main') {
      selectedIndex = 0;
    } else if (location == 'vocabulary') {
      selectedIndex = 1;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/main');
              break;
            case 1:
              context.go('/vocabulary');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library_outlined),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: "Vocabulary",
          ),
        ],
      ),
    );
  }
}
