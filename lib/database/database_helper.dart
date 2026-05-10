import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static const String taskBoxName = 'tasks';
  static const String userBoxName = 'users';

  late Box<Map> taskBox;
  late Box<Map> userBox;
  bool _initialized = false;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<void> initialize() async {
    if (_initialized) return;
    
    await Hive.initFlutter();
    
    taskBox = await Hive.openBox<Map>(taskBoxName);
    userBox = await Hive.openBox<Map>(userBoxName);

    // Create default user if not exists
    if (userBox.isEmpty) {
      await userBox.put('user', {'username': 'user', 'password': 'user'});
    }

    _initialized = true;
  }

  // Task operations
  Future<int> insertTask(Task task) async {
    await initialize();
    final taskMap = {
      'title': task.title,
      'description': task.description,
      'dueDate': task.dueDate.toIso8601String(),
      'category': task.category,
      'isCompleted': task.isCompleted,
      'createdAt': task.createdAt.toIso8601String(),
    };
    
    final id = taskBox.length;
    await taskBox.put(id, taskMap);
    return id;
  }

  Future<List<Task>> getAllTasks() async {
    await initialize();
    final List<Task> tasks = [];
    
    for (int i = 0; i < taskBox.length; i++) {
      final taskMap = taskBox.getAt(i);
      if (taskMap != null) {
        tasks.add(Task(
          id: i,
          title: taskMap['title'] as String,
          description: taskMap['description'] as String? ?? '',
          dueDate: DateTime.parse(taskMap['dueDate'] as String),
          category: taskMap['category'] as String,
          isCompleted: taskMap['isCompleted'] as bool? ?? false,
          createdAt: DateTime.parse(taskMap['createdAt'] as String),
        ));
      }
    }
    
    return tasks;
  }

  Future<List<Task>> getTasksByCategory(String category) async {
    final allTasks = await getAllTasks();
    return allTasks.where((task) => task.category == category).toList();
  }

  Future<int> updateTask(Task task) async {
    await initialize();
    final taskMap = {
      'title': task.title,
      'description': task.description,
      'dueDate': task.dueDate.toIso8601String(),
      'category': task.category,
      'isCompleted': task.isCompleted,
      'createdAt': task.createdAt.toIso8601String(),
    };
    
    await taskBox.putAt(task.id!, taskMap);
    return 1;
  }

  Future<int> deleteTask(int id) async {
    await initialize();
    await taskBox.deleteAt(id);
    return 1;
  }

  Future<int> getCompletedTasksCount() async {
    await initialize();
    int count = 0;
    for (int i = 0; i < taskBox.length; i++) {
      final taskMap = taskBox.getAt(i);
      if (taskMap != null && (taskMap['isCompleted'] as bool? ?? false)) {
        count++;
      }
    }
    return count;
  }

  Future<int> getIncompleteTasksCount() async {
    await initialize();
    int count = 0;
    for (int i = 0; i < taskBox.length; i++) {
      final taskMap = taskBox.getAt(i);
      if (taskMap != null && !(taskMap['isCompleted'] as bool? ?? false)) {
        count++;
      }
    }
    return count;
  }

  Future<Map<String, int>> getTasksCompletedByDate() async {
    await initialize();
    final Map<String, int> data = {};
    
    for (int i = 0; i < taskBox.length; i++) {
      final taskMap = taskBox.getAt(i);
      if (taskMap != null && (taskMap['isCompleted'] as bool? ?? false)) {
        final dateStr = DateTime.parse(taskMap['dueDate'] as String).toIso8601String().split('T').first;
        data[dateStr] = (data[dateStr] ?? 0) + 1;
      }
    }
    
    return data;
  }

  // User operations
  Future<bool> validateUser(String username, String password) async {
    await initialize();
    final user = userBox.get(username);
    if (user != null) {
      return user['password'] == password;
    }
    return false;
  }

  Future<bool> updatePassword(String username, String oldPassword, String newPassword) async {
    await initialize();
    
    // Validate old password
    final user = userBox.get(username);
    if (user == null || user['password'] != oldPassword) {
      return false;
    }

    // Update password
    await userBox.put(username, {
      'username': username,
      'password': newPassword,
    });
    
    return true;
  }

  // Login method
  Future<bool> login(String username, String password) async {
    return validateUser(username, password);
  }
}
