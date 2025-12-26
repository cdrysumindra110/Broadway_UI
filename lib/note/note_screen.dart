import 'package:broadway_example_ui/login_screen.dart';
import 'package:broadway_example_ui/note/note_database.dart';
import 'package:broadway_example_ui/note/note_model.dart';
import 'package:broadway_example_ui/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  NoteDatabase database = NoteDatabase();
  List<NoteModel> notes = [];
  String? name;
  String? email;
  @override
  void initState() {
    getData();
    // getName();
    super.initState();
  }

  Future<void> getData() async {
    final nt = await database.getData();
    getName();
    setState(() {
      notes = nt;
    });
  }

  void showAddEditBottomSheet(NoteModel? notes) {
    final titleController = TextEditingController(text: notes?.title ?? "");
    final descriptionController = TextEditingController(
      text: notes?.description ?? "",
    );
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Notes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  label: Text("Decription"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // notes == null ? print("isnull") : print("notNull");
                  final note = NoteModel(
                    id: notes?.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    name: name ?? "",
                    email: email ?? "",
                  );
                  if (notes == null) {
                    int result = await database.insert(note);
                    if (result > 0) {
                      getData();
                    }
                  } else {
                    int result = await database.updateData(note);
                    if (result > 0) {
                      getData();
                    }
                  }
                  Fluttertoast.showToast(
                    msg: "Data added sucessfully",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );

                  // Navigator.pop(context);
                },
                child: Text("Add"),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void getName() async {
    name = await SharedData.getName();
    email = await SharedData.getEmail();
    print("welcome $name $email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note screen"),
        actions: [
          IconButton(
            onPressed: () async {
              await SharedData.clearLogout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddEditBottomSheet(null);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => getData(),
        child: Column(
          children: [
            Text("Welcome $name"),
            Expanded(
              child: notes.isEmpty
                  ? Text("No Notes to display")
                  : ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final noteData = notes[index];
                        return Container(
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {
                                showAddEditBottomSheet(noteData);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            title: Text(noteData.title),
                            subtitle: Column(
                              children: [
                                Text(noteData.description),
                                Text("By ${noteData.name}"),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                final result = await database.delete(
                                  noteData.id ?? 0,
                                );
                                if (result > 0) {
                                  getData();
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Delete successfully"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
