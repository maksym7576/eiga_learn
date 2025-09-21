import 'package:eiga_learn/models/DurationAdapter.dart';
import 'package:eiga_learn/models/VideoObject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:eiga_learn/navigators/AppRouter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:eiga_learn/providers/DatabaseProviders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(VideoObjectAdapter());
  // Hive.registerAdapter(PhraseObjectAdapter());
  Hive.registerAdapter(DurationAdapter());
  // await Hive.deleteBoxFromDisk('videoBox');
  final videoBox = await Hive.openBox<VideoObject>('videoBox');

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    ProviderScope(
      overrides: [
        videoBoxProvider.overrideWithValue(videoBox),
        // phraseBoxProvider.overrideWithValue(phraseBox),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
