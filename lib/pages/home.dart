import 'package:first_app_flutter/domain/local/todo_database.dart';
import 'package:first_app_flutter/main.dart';
import 'package:first_app_flutter/models/todo_model.dart';
import 'package:first_app_flutter/widgets/todo_card.dart';
import 'package:flutter/material.dart';

import 'create_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _database = getIt<TodoDatabase>();
  final _textEditController = TextEditingController();
  List<Todo> _list = List.empty();
  List<Todo> _filteredList = List.empty();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _searchTodo(String term) {
    setState(() {
      _filteredList = _list.where((element) {
        RegExp regex = RegExp(term, caseSensitive: false);
        return element.title.contains(regex) ||
            element.description.contains(regex);
      }).toList();
    });
  }

  void _loadTodos() {
    _database.todoDao.findAllTodos().then((value) {
      setState(() {
        _list = value;
        _filteredList = _list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            SearchBar(
                controller: _textEditController,
                elevation: WidgetStateProperty.all<double>(0),
                hintText: "Pesquisar",
                onSubmitted: (_) => _searchTodo(_textEditController.text),
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _textEditController.text = "";
                      _searchTodo(_textEditController.text);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _searchTodo(_textEditController.text),
                  )
                ]),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _filteredList.length,
                itemBuilder: (context, index) {
                  return Stack(children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 16.0),
                          color: Colors.redAccent,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                    ),
                    Dismissible(
                      key: Key(_filteredList[index].id.toString()),
                      onDismissed: (direction) {
                        _database.todoDao
                            .deleteTodo(_filteredList[index])
                            .then((value) => _loadTodos());
                      },
                      direction: DismissDirection.startToEnd,
                      confirmDismiss: (direction) async {
                        return direction == DismissDirection.startToEnd;
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: TodoCard(
                          title: _filteredList[index].title,
                          description: _filteredList[index].description,
                          tapCallback: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateTodoPage(
                                        todo: _filteredList[index])));
                            _loadTodos();
                          },
                        ),
                      ),
                    ),
                  ]);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
              ),
            )
          ])),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateTodoPage(todo: null)));
            _loadTodos();
          }),
    );
  }
}
