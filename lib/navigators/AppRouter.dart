import 'package:eiga_learn/navigators/AppNavigator.dart';
import 'package:eiga_learn/screens/MainScreen.dart';
import 'package:eiga_learn/screens/VideoScreen.dart';
import 'package:eiga_learn/screens/VocabularyScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

final GoRouter AppRouter = GoRouter(
  initialLocation: '/main',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppNavigator(child: child),
      routes: [
        GoRoute(path: '/main', builder: (context, state) => const MainScreen()),
        GoRoute(
          path: 'vocabulary',
          builder: (context, state) => const VocabularyScreen(),
        ),
      ],
    ),
    GoRoute(path: 'video', builder: (context, state) => const VideoScreen()),
  ],
);
