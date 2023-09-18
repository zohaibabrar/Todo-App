// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_firebase/screen/add_task_screen.dart';

import '../controller/database.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Tasks'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: firebaseFirestore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final result = snapshot.data!.docs[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${result['title']}'),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTaskScreen(
                                screenTitle: 'Edit Task',
                                id: result.id,
                                taskTitle: result['title'],
                                taskDescription: result['description'],
                                buttonTitle: 'Edit',
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          Database.deleteTask(result.id);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                screenTitle: 'Add Task',
                buttonTitle: 'Add',
              ),
            ),
          );
        },
        child: Center(
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}
