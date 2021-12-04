import 'package:flutter_app3/db/dbhelper.dart';
import 'package:flutter_app3/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final RxList tasksList = [].obs;
  Future<int> addTask({Task? myTask}) async {
    return await DBhelper.insert(myTask);
  }

  Future<void> getTasks() async {
    final tasks = await DBhelper.getData();
    tasksList.assignAll(tasks.map((e) => Task.fromMap(e)));
  }

  Future<void> completeTask(Task myTask) async {
     await DBhelper.update(myTask);
    await getTasks();
  }

  Future<void> deleteTask(Task myTask) async {
    await DBhelper.delete(myTask);
    await getTasks();
  }
}
