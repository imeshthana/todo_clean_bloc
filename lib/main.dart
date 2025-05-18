import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_clean_bloc/data/repository/todo_repository_impl.dart';
import 'package:todo_clean_bloc/presentation/todo_page.dart';

void main() {
  final httpClient = http.Client();
  final todoRepository = TodoRepositoryImpl(client: httpClient);

  runApp(DevicePreview(
    builder: (context) => MyApp(todoRepository: todoRepository),
  ));
}

class MyApp extends StatelessWidget {
  final TodoRepositoryImpl todoRepository;

  const MyApp({super.key, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: TodoPage(todoRepo: todoRepository),
      debugShowCheckedModeBanner: false,
    );
  }
}
