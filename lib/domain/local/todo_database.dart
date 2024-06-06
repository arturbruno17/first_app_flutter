import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:first_app_flutter/domain/local/todo_dao.dart';
import 'package:first_app_flutter/models/todo_model.dart';


part 'todo_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Todo])
abstract class TodoDatabase extends FloorDatabase {
  TodoDao get todoDao;
}