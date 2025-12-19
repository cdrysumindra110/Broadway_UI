import 'package:broadway_example_ui/users/user_model.dart';
import 'package:broadway_example_ui/users/user_service.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserService service = UserService();
  List<UserModel> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Screen")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final data = await service.getUser();
              setState(() {
                users = data;
              });
            },
            child: Text("Get Data"),
          ),
          Expanded(
            // height: 500,
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final data = users[index];
                return ListTile(
                  leading: Text("${data.id}"),
                  title: Text(data.title),
                  subtitle: Text(data.body ?? ""),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        users.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
