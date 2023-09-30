import 'package:flutter/material.dart';
import 'package:task_app/utilities/dialog_box.dart';
import 'package:task_app/utilities/todo_tile.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  List toDoList = [
    ["test Text", false],
    ["finish the app", false],
  ];
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox();
      },
    );
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
        itemCount: toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(taskName: toDoList[index][0], 
                          taskCompleted: toDoList[index][1], 
                          onChanged: (value) => checkBoxChanged(value, index),);
        },
      )
      );
  }
}