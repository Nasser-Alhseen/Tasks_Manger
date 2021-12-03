import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/controllers/controller.dart';
import 'package:flutter_app3/db/dbhelper.dart';
import 'package:flutter_app3/models/task.dart';
import 'package:flutter_app3/services/notification_services.dart';
import 'package:flutter_app3/services/them_services.dart';
import 'package:flutter_app3/ui/pages/add_task.dart';
import 'package:flutter_app3/ui/size_config.dart';
import 'package:flutter_app3/ui/theme.dart';
import 'package:flutter_app3/ui/widgets/input_field.dart';
import 'package:flutter_app3/ui/widgets/my_button.dart';
import 'package:flutter_app3/ui/widgets/task_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TaskController controller = Get.put(TaskController(), permanent: true);
  late DateTime selectedDate;
  late NotificationServices notHelper;
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    notHelper = NotificationServices();
    notHelper.requestPermision();
    notHelper.initialNotify();
    controller.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    controller.getTasks();

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.person,
                size: 30,
              ))
        ],
        leading: IconButton(
          icon: Icon(
            Get.isDarkMode ? Icons.dark_mode : Icons.wb_sunny,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            size: 25,
          ),
          onPressed: () => setState(() {
            ThemeServices().switchTheme();
            controller.getTasks();
          }),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
      ),
      body: Column(
        children: [
          addTaskBar(),
          addDateBar(),
          const SizedBox(
            height: 10,
          ),
          showTasks(),
        ],
      ),
    );
  }

  Widget buildBottomSheet({
    required String label,
    required Function on_tap,
    required Color color,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: () {
        on_tap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 40,
        width: SizeConfig.screeWidth * 0.9,
        decoration: BoxDecoration(
            color: isClose ? Colors.transparent : color,
            border: Border.all(
              width: 2,
              color: isClose
                  ? Get.isDarkMode
                      ? darkGreyC
                      : darkGreyC.withOpacity(0.6)
                  : color,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            label,
            style: titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  showBottomSheet(BuildContext context, Task myTask) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: context.theme.backgroundColor,
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.only(top: 5),
        width: SizeConfig.screeWidth,
        height: (SizeConfig.screenOrientation == Orientation.landscape)
            ? (myTask.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (myTask.isCompleted == 1
                ? SizeConfig.screenHeight * 0.3
                : SizeConfig.screenHeight * 0.4),
        child: Column(children: [
          Flexible(
            child: Container(
              height: 7,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.black : Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          (myTask.isCompleted == 1
              ? Container()
              : buildBottomSheet(
                  label: 'Task Completed',
                  on_tap: ()  {
                    controller.completeTask(myTask.id!);
                    Get.back();
                  },
                  color: context.theme.primaryColor,
                )),
          buildBottomSheet(
            label: 'Delete Task ',
            on_tap: () {
              controller.deleteTask(myTask);
              Get.back();
            },
            color: context.theme.primaryColor,
          ),
          Divider(
            color: context.theme.primaryColor,
            thickness: 1,
          ),
          buildBottomSheet(
            label: 'Cancel',
            on_tap: () {
              Get.back();
            },
            color: context.theme.primaryColor,
          ),
          const SizedBox(
            height: 20,
          )
        ]),
      ),
    ));
  }

  addTaskBar() {
    controller.getTasks();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat().add_yMMMMd().format(DateTime.now()).toString()),
              Text(
                "Today",
                style: titleStyle1,
              )
            ],
          ),
          MyButtton(
              label: '+ Add Task',
              onTap: () async {
                await Get.to(() => AddTaskPage());
                controller.getTasks();
                //controller.getTasks();
              })
        ],
      ),
    );
  }

  addDateBar() {
    controller.getTasks();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: selectedDate,
        dayTextStyle: const TextStyle(color: Colors.grey),
        monthTextStyle: const TextStyle(color: Colors.grey),
        dateTextStyle: const TextStyle(color: Colors.grey),
        selectionColor: context.theme.primaryColor,
        selectedTextColor: whiteC,
        onDateChange: (newDate) {
          selectedDate = newDate;
        },
      ),
    );
  }

  Future<void> refresh() async {
    await controller.getTasks();
  }

  showTasks() {
    return Expanded(
      child: GetX<TaskController>(
        init: TaskController(),
        builder: (c) {
          if (controller.tasksList.isEmpty) {
            return noTask();
          } else {
            var tasks = c.tasksList;
            return RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (c, int i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                          onTap: () {
                            showBottomSheet(
                                context,
                                Task(
                                    title: tasks[i]['title'],
                                    note: tasks[i]['note'],
                                    isCompleted: tasks[i]['isCompleted'],
                                    color: tasks[i]['color'],
                                    date: tasks[i]['date'],
                                    endTime: tasks[i]['endTime'],
                                    startTime: tasks[i]['startTime'],
                                    reminder: tasks[i]['reminder'],
                                    repeat: tasks[i]['repeat']));
                          },
                          child: MyTile(
                            myTask: Task(
                                title: tasks[i]['title'],
                                note: tasks[i]['note'],
                                isCompleted: tasks[i]['isCompleted'],
                                color: tasks[i]['color'],
                                date: tasks[i]['date'],
                                endTime: tasks[i]['endTime'],
                                startTime: tasks[i]['startTime'],
                                reminder: tasks[i]['reminder'],
                                repeat: tasks[i]['repeat']),
                          )),
                      // child: MyTile(myTask: tasks[i])),
                    );
                  }),
            );
          }
        },
      ),
    );
  }

  noTask() {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                SvgPicture.asset('images/task.svg',
                    width: 100, height: 100, color: context.theme.primaryColor),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Text(
                    'You Have not Added Any Tasks Yet\nAdd More Tasks to Make Your Day Productive',
                    textAlign: TextAlign.center,
                    style: subHeading,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
