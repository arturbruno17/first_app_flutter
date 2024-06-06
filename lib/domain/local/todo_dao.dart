import 'package:first_app_flutter/models/todo_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class TodoDao {

  @Query("SELECT * FROM Todo")
  Future<List<Todo>> findAllTodos();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTodo(Todo todo);

  @delete
  Future<void> deleteTodo(Todo todo);

}