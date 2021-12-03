import 'package:flutter/material.dart';
import 'package:flutter_app3/controllers/controller.dart';
import 'package:flutter_app3/db/dbhelper.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  TaskController controller = Get.put(TaskController(), permanent: true);
  @override
  void initState() {
    DBhelper.initDB();
    controller.getTasks();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.getTasks();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  // DBhelper.insert();
                  controller.getTasks();
                },
                child: Text("ref")),
            ListView.builder(
              shrinkWrap:true,
              itemCount: 4,
              itemBuilder: (c, i) {
                return Container(
                  child: Center(
                    child: GetX<TaskController>(
                      init: TaskController(),
                      builder: (c) {
                        return Text(c.tasksList[i]['title'].toString());
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
