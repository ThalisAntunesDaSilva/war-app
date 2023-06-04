import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/todo.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  Expanded(
                    child: Text(
                      'Bem-vindo(a)! Ana Lucia',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  SizedBox(width: 8),
                ]),
                Row(
                  children: [
                    Expanded(
                      child: Text('Consultas recentes'),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF6295E2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/image-dra.png'),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. Ana Lucia',
                                  style: TextStyle(
                                      fontSize: 24.0, color: Colors.white),
                                ),
                                Text(
                                  'Limpeza',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                  size: 24.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '23 Mar',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.white,
                                  size: 24.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '16:00',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFFF6C52),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Histórico',
                                      style: TextStyle(
                                          fontSize: 24.0, color: Colors.white),
                                    ),
                                    Text(
                                      'Veja suas consultas anteriores',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Image(
                                  image: AssetImage(
                                      'assets/images/icon-button-historic.png'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF66CA98),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Receba recompensas',
                                  style: TextStyle(
                                      fontSize: 24.0, color: Colors.white),
                                ),
                                Text(
                                  'Indique um amigo e receba recompensas',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 35),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(height: 45),
                    Expanded(
                      child: Text(
                        'Categorias de Atendimento',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Tarefa ${todo.title} foi removida com sucesso'),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          setState(() {
            todos.insert(deletedTodoPos!, deletedTodo!);
          });
        },
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  void showDeleteTodosConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar tudo'),
        content: Text('Tem certeza disso?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteAllTodos();
              },
              child: Text('Ok')),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
  }
}
