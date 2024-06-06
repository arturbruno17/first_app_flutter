import 'package:first_app_flutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'domain/local/todo_database.dart';

final getIt = GetIt.instance;

setup() async {
  getIt.registerSingleton<TodoDatabase>(await $FloorTodoDatabase.databaseBuilder('todo_database.db').build());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true),
      home: const HomePage(),
    );
  }
}
