import 'package:broadway_example_ui/note/note_database.dart';
import 'package:broadway_example_ui/note/note_model.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  NoteDatabase noteDb = NoteDatabase();
  List<NoteModel> notes = [];

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future<void> refreshNotes() async {
    final data = await noteDb.getData();
    setState(() {
      notes = data;
    });
  }

  void showAddEditBottomSheet({NoteModel? note}) {
    final titleController = TextEditingController(text: note?.title ?? "");
    final descriptionController = TextEditingController(text: note?.description ?? "");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16, right: 16, top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                note == null ? "Add Note" : "Edit Note",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(label: Text("Title"), border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(label: Text("Description"), border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (note == null) {
                    final newNote = NoteModel(
                      title: titleController.text,
                      description: descriptionController.text,
                    );
                    await noteDb.insert(newNote);
                  } else {
                    final updatedNote = NoteModel(
                      id: note.id,
                      title: titleController.text,
                      description: descriptionController.text,
                    );
                    await noteDb.update(updatedNote);
                  }
                  refreshNotes();
                  Navigator.pop(context);
                },
                child: Text(note == null ? "Add" : "Update"),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Note Screen")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddEditBottomSheet(),
        child: Icon(Icons.add),
      ),
      body: notes.isEmpty 
        ? Center(child: Text("No notes found"))
        : ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => showAddEditBottomSheet(note: note),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await noteDb.delete(note.id!);
                        refreshNotes();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}