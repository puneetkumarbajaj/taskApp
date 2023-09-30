import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_app/data/database.dart';
import 'package:task_app/utilities/dialog_box.dart';
import 'package:task_app/utilities/todo_tile.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  //referencing the hive box
  final _myBox = Hive.box('toDoListBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    //if this is the first time ever opening the app, then have some default data
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }
    else{
      //there is some data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //when checkbox is tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }
  //saves a new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  //creates a new task
  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: ()=> Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task function
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('To Do'),
        elevation: 0,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),);
        },
      )
      );
  }
}