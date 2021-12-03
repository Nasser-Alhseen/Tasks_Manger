import 'package:flutter_app3/db/dbhelper.dart';
import 'package:flutter_app3/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final RxList tasksList = [].obs;
  Future<int> addTask({Task? myTask}) async {
    return await DBhelper.insert(myTask);
  }

  Future<void> getTasks() async {
    print('getting');
    final tasks = await DBhelper.getData();
    print(tasks.toString());
    tasksList.assignAll(tasks.map((e) => e));
  }

  Future<void> completeTask(int id) async {
    await DBhelper.update(id);
    getTasks();
  }

  Future<void> deleteTask(Task myTask) async {
    await DBhelper.delete(myTask);
    getTasks();
  }
}
