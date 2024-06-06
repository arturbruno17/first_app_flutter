import 'package:first_app_flutter/domain/local/todo_database.dart';
import 'package:first_app_flutter/main.dart';
import 'package:first_app_flutter/models/todo_model.dart';
import 'package:flutter/material.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key, required this.todo});

  final Todo? todo;

  @override
  State<StatefulWidget> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final TodoDatabase _database = getIt<TodoDatabase>();
  final TextEditingController _titleTextFieldController =
      TextEditingController();
  final TextEditingController _descriptionTextFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleTextFieldController.text = widget.todo?.title ?? "";
      _descriptionTextFieldController.text = widget.todo?.description ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Todo App"),
        actions: [
          IconButton(
              onPressed: () {
                _database.todoDao.insertTodo(Todo(
                    id: widget.todo?.id,
                    title: _titleTextFieldController.text,
                    description: _descriptionTextFieldController.text));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          const SizedBox(height: 16),
          TextField(
            controller: _titleTextFieldController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              hintText: "Título",
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextField(
                  maxLines: -1 >>> 1,
                  controller: _descriptionTextFieldController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Descrição",
                    filled: true,
                    fillColor:
                        Theme.of(context).colorScheme.surfaceContainerHigh,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        borderSide: BorderSide.none),
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
