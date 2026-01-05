import 'package:broadway_example_ui/todo/todo_screen.dart';
import 'package:broadway_example_ui/users/user_bloc.dart';
import 'package:broadway_example_ui/users/user_event.dart';
import 'package:broadway_example_ui/users/user_model.dart';
import 'package:broadway_example_ui/users/user_service.dart';
import 'package:broadway_example_ui/users/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // UserService service = UserService();
  // List<UserModel> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodoScreen()),
              );
            },
            icon: Icon(Icons.abc),
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              context.read<UserBloc>().add(GetUser());
              // final data = await service.getUser();
              // setState(() {
              //   users = data;
              // });
            },
            child: Text("Get Data"),
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is UserLoaded) {
                return Expanded(
                  // height: 500,
                  child: ListView.builder(
                    itemCount: state.user.length,
                    itemBuilder: (context, index) {
                      final data = state.user[index];
                      return ListTile(
                        leading: Text("${data.id}"),
                        title: Text(data.title),
                        subtitle: Text(data.body ?? ""),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              state.user.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is UserError) {
                return Center(child: Text("Error"));
              }
              return Center(child: Text("refresh data"));
            },
          ),
        ],
      ),
    );
  }
}
