import 'package:broadway_example_ui/database/database.dart';
import 'package:broadway_example_ui/todo/todo_model.dart';
import 'package:broadway_example_ui/users/user_screen.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  final updateTitleController = TextEditingController();
  final updateBodyController = TextEditingController();

  List<TodoModel> todos = [];
  @override
  void initState() {
    getTodoData();
    super.initState();
  }

  Future<void> getTodoData() async {
    final data = await DBHelper.instance.getTodo();
    setState(() {
      todos = data;
      // todos.add(data);
    });
  }
  showUppdateBottomSheet(TodoModel todo) {
    updateTitleController.text = todo.title;
    updateBodyController.text = todo.body;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Update Todo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              TextField(
                controller: updateTitleController,
                decoration: InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: updateBodyController,
                decoration: InputDecoration(
                  label: Text("Body"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final updatedTodo = TodoModel(
                    id: todo.id,
                    title: titleController.text,
                    body: bodyController.text,
                  );
                  final result = await DBHelper.instance.update(updatedTodo);
                  if(result > 0){
                    getTodoData();
                  }
                  Navigator.pop(context);
                },
                child: Text("Update"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo Screen")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text("Title"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: bodyController,
              decoration: InputDecoration(
                label: Text("Body"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text;
                final body = bodyController.text;
                final data = TodoModel(title: title, body: body);
                final value = await DBHelper.instance.insertTodo(data);

                titleController.clear();
                bodyController.clear();
                if (value > 0) {
                  getTodoData();
                }

                print('Title: $title,Body:$body');
              },
              child: Text("Add"),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     final data = await DBHelper.instance.getTodo();
            //     print(data);
            //   },
            //   child: Text("Get Data"),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.body),
                    trailing: IconButton(
                      onPressed: () {
                        DBHelper.instance.edit(todo.id ?? 0);
                        setState(() {
                          todos.removeAt(index);
                        });

                        print("${todo.id} is deleted");
                      },
                      icon: Icon(Icons.edit, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.body),
                    trailing: IconButton(
                      onPressed: () {
                        DBHelper.instance.delete(todo.id ?? 0);
                        setState(() {
                          todos.removeAt(index);
                        });

                        print("${todo.id} is deleted");
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                );
              },
              child: Text("Next screen"),
            ),
          ],                  
        ),
      ),
    );
  }
}
