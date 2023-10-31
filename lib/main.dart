import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:todo/config/factories/app.factory.dart';
import 'package:todo/config/routers/app.router.dart';
import 'package:todo/pages/setting/setting.controller.dart';
import 'package:todo/pages/task/task_list.controller.dart';
import 'package:todo/shared/services/notification.service.dart';
import 'package:todo/shared/services/theme.service.dart';

import 'config/theme/theme.dark.dart';
import 'config/theme/theme.ligth.dart';
import 'shared/providers/storage.provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("todo_task");
  NotificationService().initNotification();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SharedPreferencesProvider()),
        ChangeNotifierProvider(create: (context) => TaskListController(context: context)),
        ChangeNotifierProvider(create: (context) => SettingController(context)),

      ],
      child: MyApp(),
    ),);
}

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppFactory appFactory = AppFactory.instance;

  late ThemeService themeService;

  @override
  Widget build(BuildContext context) {
    themeService = ThemeService(context);
    // themeService.getStorage();
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appFactory.notifier,
      builder: (_, mode, __) {
        return MaterialApp.router(
          key: MyApp.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: themeLigth,
          darkTheme: themeDark,
          themeMode: appFactory.onThemeMode(mode),
          routerConfig: appRouters,
        );
      },
    );
  }
}
