// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:todo_firebase/controller/database.dart';

class AddTaskScreen extends StatelessWidget {
  String screenTitle;
  String buttonTitle;
  String? taskTitle;
  String? taskDescription;
  String? id;

  AddTaskScreen({
    Key? key,
    required this.screenTitle,
    required this.buttonTitle,
    this.taskTitle,
    this.taskDescription,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController taskController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  // label: Text('Task'),
                  hintText: taskTitle,
                ),
                controller: taskController,
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  // label: Text('Task Detail'),
                  hintText: taskDescription,
                ),
                controller: detailController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (buttonTitle == 'Add') {
                    Database.addTask(
                        taskController.text, detailController.text);
                  } else if (buttonTitle == 'Edit') {
                    Database.updateTask(
                        id!, taskController.text, detailController.text);
                  }
                  Navigator.pop(context);
                },
                child: Text(buttonTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
