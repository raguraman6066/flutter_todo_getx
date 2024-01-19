import 'package:flutter/material.dart';
import 'package:flutter_todo_getx/screens/my_note.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller.dart';

class NoteList extends StatefulWidget {
  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final themeData = GetStorage();

  @override
  Widget build(BuildContext context) {
    themeData.writeIfNull('darkMode', false);
    bool darkTheme = themeData.read('darkMode');
    final NoteController nc = Get.put(NoteController());
    Widget getNoteList() {
      return Obx(
        () => nc.notes.length == 0
            ? Center(
                child: Image.asset('assets/lists.jpeg'),
              )
            : ListView.builder(
                itemCount: nc.notes.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                          title: Text(nc.notes[index].title,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: Text(
                            (index + 1).toString() + ".",
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Wrap(children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.create),
                                onPressed: () => Get.to(MyNote(index: index))),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: 'Delete Note',
                                      middleText: nc.notes[index].title,
                                      onCancel: () => Get.back(),
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        nc.notes.removeAt(index);
                                        Get.back();
                                      });
                                })
                          ])),
                    )),
      );
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Todo App'),
              actions: [],
            ),
            floatingActionButton: SwitchListTile(
                value: darkTheme,
                onChanged: (value) {
                  setState(() {
                    darkTheme = value;
                  });
                  darkTheme
                      ? Get.changeTheme(ThemeData.dark())
                      : Get.changeTheme(ThemeData.light());
                  themeData.write("darkMode", value);
                }),
            body: Container(
              child: Padding(padding: EdgeInsets.all(5), child: getNoteList()),
            )));
  }
}
