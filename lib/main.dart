import 'package:flutter/material.dart';
import 'package:flutter_app3/controllers/controller.dart';
import 'package:flutter_app3/db/dbhelper.dart';
import 'package:flutter_app3/services/notification_services.dart';
import 'package:flutter_app3/services/them_services.dart';
import 'package:flutter_app3/test.dart';
import 'package:flutter_app3/ui/pages/add_task.dart';
import 'package:flutter_app3/ui/pages/home.dart';
import 'package:flutter_app3/ui/theme.dart';
import 'package:get/get.dart';

void main() async {
  TaskController t = Get.put(TaskController());
  WidgetsFlutterBinding.ensureInitialized();
  await DBhelper.initDB();
  await t.getTasks();
    runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
