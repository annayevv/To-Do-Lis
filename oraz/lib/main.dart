import 'package:flutter/material.dart';

void main() => runApp(Oraz());

class Task {
  final String name;
  final String date;
  final String time;
  final bool isImportant;

  Task({
    required this.name,
    required this.date,
    required this.time,
    required this.isImportant,
  });
}

class Oraz extends StatefulWidget {
  const Oraz({super.key});

  @override
  State<Oraz> createState() => _MyAppState();
}

class _MyAppState extends State<Oraz> {
  bool isDark = false;
  List<Task> tasks = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  void _showModalBottomSheet(BuildContext context) {
    bool isImportant = false;

    nameController.clear();
    dateController.clear();
    timeController.clear();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: SizedBox(
                height: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Handle bar
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "What should you do:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Işiň ady',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "What Date:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Date (2025-06-23)',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "When:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: timeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Time (14:30)',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Is this work important?",
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: isImportant,
                          onChanged: (value) {
                            setModalState(() {
                              isImportant = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              // Validate input
                              if (nameController.text.trim().isEmpty ||
                                  dateController.text.trim().isEmpty ||
                                  timeController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please fill all fields'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              setState(() {
                                tasks.add(
                                  Task(
                                    name: nameController.text.trim(),
                                    date: dateController.text.trim(),
                                    time: timeController.text.trim(),
                                    isImportant: isImportant,
                                  ),
                                );
                              });

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Task added successfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            child: Text("Add", style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task deleted'), backgroundColor: Colors.orange),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? darkTheme : lightTheme,
      home: Scaffold(
        backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
        appBar: AppBar(
          title: Text(
            "Annayevv To Do List",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.black : Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.sunny : Icons.nightlight_round),
              tooltip: isDark ? 'Açyk tema' : 'Garaňky tema',
              color: isDark ? Colors.amberAccent : Colors.white,
              padding: EdgeInsets.only(right: 20.0),
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
            ),
          ],
        ),
        body: Builder(
          builder:
              (BuildContext context) => Column(
                children: [
                  // Header section
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "To Do List",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              "${tasks.length} tasks",
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    isDark
                                        ? Colors.grey[300]
                                        : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        FloatingActionButton(
                          onPressed: () => _showModalBottomSheet(context),
                          backgroundColor: isDark ? Colors.blue : Colors.blue,
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                        tasks.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    "Add a task to get started",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          isDark
                                              ? Colors.grey[500]
                                              : Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                final task = tasks[index];
                                return Card(
                                  margin: EdgeInsets.only(bottom: 12),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          task.isImportant
                                              ? Border.all(
                                                color: Colors.red,
                                                width: 2,
                                              )
                                              : null,
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(16),
                                      leading: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color:
                                              task.isImportant
                                                  ? Colors.red
                                                  : Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      title: Text(
                                        task.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                size: 16,
                                                color: Colors.grey[600],
                                              ),
                                              SizedBox(width: 4),
                                              Text(task.date),
                                              SizedBox(width: 16),
                                              Icon(
                                                Icons.access_time,
                                                size: 16,
                                                color: Colors.grey[600],
                                              ),
                                              SizedBox(width: 4),
                                              Text(task.time),
                                            ],
                                          ),
                                          if (task.isImportant) ...[
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.priority_high,
                                                  size: 16,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Important",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => _deleteTask(index),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);
