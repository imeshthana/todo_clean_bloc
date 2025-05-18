import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_bloc/domain/models/todo.dart';
import 'package:todo_clean_bloc/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      todoCubit.addTodo(textController.text);
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showAddTodoBox(context),
        ),
        body: BlocBuilder<TodoCubit, List<Todo>>(builder: (context, todos) {
          if (todos.isEmpty) return Center(child: Text('Empty list'));
          return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                    title: Text(todo.text),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => todoCubit.deleteTodo(todo),
                    ),
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) => todoCubit.toggleCompletion(todo),
                    ));
              });
        }));
  }
}
