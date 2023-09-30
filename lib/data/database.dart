import 'package:hive/hive.dart';

class ToDoDatabase{

  List toDoList = [];

  //reference the box
  final dataBox = Hive.box('toDoListBox');

  //method to initiate first run of the app (the first ever. Fresh install)
  void createInitialData(){
    toDoList = [
      ["Complete CW#3", true],
      ["Start workin on group proposal", false],
    ];
  }
  //load data from database
  void loadData(){
    toDoList = dataBox.get('TODOLIST');
  }

  //update the database
  void updateData(){
    dataBox.put("TODOLIST", toDoList);
  }
}