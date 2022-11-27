import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/data/locale_storage.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:flutter_todo_app/pages/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final locator = GetIt.instance;

void _setup() {
  locator.registerSingleton<LocaleStorage>(HiveLocaleStorage());
}

Future<void> _setupHive() async {
  await Hive.initFlutter('application');
  Hive.registerAdapter(TaskAdapter());

  var taskBox = await Hive.openBox<Task>('tasks');

  for (var task in taskBox.values) {
    if (task.createdTask.day != DateTime.now().day) {
      taskBox.delete(task.id);
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized(); // Localization

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await _setupHive();

  _setup();

  // runApp(const MyApp()); // Normal
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()),
  ); //  Localization
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates, //  Localization
      supportedLocales: context.supportedLocales, //  Localization
      //locale: context.locale, //  Localization
      locale: context.deviceLocale, //  Localization

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.black,
              ))),
      home: const HomePage(),
    );
  }
}
