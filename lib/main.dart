import 'package:flutter/material.dart';
import 'package:flutter_todo_getx/screens/notes_list.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final getStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    bool darkMode = getStorage.read('darkMode') ?? false;
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      home: NoteList(),
    );
  }
}
