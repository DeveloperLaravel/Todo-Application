import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Box todoBox = Hive.box('todoBox');
  List<String> todoList = [];

  // Normal of Method
  //  1- final TextEditingController _controller = TextEditingController();

  // Dependency of Method
  //  2- final TextEditingController _controller = TextEditingController();
  late final TextEditingController _controller;
  int updateIndex = -1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    final data = todoBox.get('todos');
    if (data != null) {
      todoList = List<String>.from(data);
    }
  }

  addList(String task) {
    if (task.isEmpty) return;
    setState(() {
      todoList.add(task);
      saveData();
      _controller.clear();
    });
  }

  updateListItem(String task, int index) {
    if (task.isEmpty) return;
    setState(() {
      todoList[index] = task;
      updateIndex = -1;
      saveData();
      _controller.clear();
    });
  }

  deleteItem(index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void saveData() {
    todoBox.put('todos', todoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo Application',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.green,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 80,
                            child: Text(
                              todoList[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _controller.clear();
                                _controller.text = todoList[index];
                                updateIndex = index;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              deleteItem(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 70,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 70,
                          child: SizedBox(
                            height: 60,
                            child: TextFormField(
                              controller: _controller,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                                filled: true,
                                labelText: 'Create  Task....',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        FloatingActionButton(
                          backgroundColor: Colors.green,
                          focusColor: Colors.white,
                          onPressed: () {
                            updateIndex != -1
                                ? updateListItem(_controller.text, updateIndex)
                                : addList(_controller.text);
                          },
                          child: Icon(
                            updateIndex != -1 ? Icons.edit : Icons.add,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
