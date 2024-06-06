import 'package:floor/floor.dart';

@Entity()
class Todo {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String description;

  Todo({
    required this.id,
    required this.title,
    required this.description
  });
}