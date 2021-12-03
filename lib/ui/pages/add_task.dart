import 'package:flutter/material.dart';
import 'package:flutter_app3/controllers/controller.dart';
import 'package:flutter_app3/db/dbhelper.dart';
import 'package:flutter_app3/models/task.dart';
import 'package:get/get.dart';

import 'package:flutter_app3/ui/theme.dart';
import 'package:flutter_app3/ui/widgets/input_field.dart';
import 'package:flutter_app3/ui/widgets/my_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  void initState() {
    // TODO: implement initState
    DBhelper.initDB();
    super.initState();
  }

  final TaskController controller = Get.put(TaskController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String startDate = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endDate = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int selectedRemind = 5;
  List<int> Reminds = const [5, 10, 15, 20];
  String selectedRepeat = 'none';
  List<String> Repeat = ['none', 'weakly', 'monthly', 'yearly'];
  int selectedColor = 0;
  validateInput() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTaskTodb();
      Get.back();
    } else if (titleController.text.isNotEmpty ||
        noteController.text.isNotEmpty) {
      Get.snackbar('Required', 'Make Sure To enter all Fields',
          colorText: context.theme.primaryColor,
          backgroundColor: whiteC,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } else {
      print('ERROR');
    }
  }

  addTaskTodb() async {
    int x = await controller.addTask(
        myTask: Task(
            title: titleController.text.toString(),
            note: noteController.text.toString(),
            isCompleted: 0,
            date: DateFormat.yMd().format(selectedDate),
            startTime: startDate,
            endTime: endDate,
            color: selectedColor,
            repeat: selectedRepeat,
            reminder: selectedRemind));
    print("Added");
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBar() {
      return AppBar(
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.person,
                size: 30,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ))
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            size: 25,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
      );
    }

    getDate() async {
      DateTime? selcted = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
      );
      if (selcted != null) {
        setState(() {
          selectedDate = selcted;
        });
      }
    }

    getTime(bool isStart) async {
      TimeOfDay? selcted = await showTimePicker(
        context: context,
        initialTime: isStart
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(
                DateTime.now().add(const Duration(minutes: 15))),
      );
      String formatedTime = selcted!.format(context);

      if (isStart) {
        setState(() {
          startDate = formatedTime;
        });
      } else {
        setState(() {
          endDate = formatedTime;
        });
      }
    }

    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),
              Text(
                'Add Task',
                style: titleStyle1,
              ),
              SizedBox(height: 8),
              MyInput(
                title: 'Title',
                hint: 'Enter Title',
                controller: titleController,
              ),
              MyInput(
                title: 'Note',
                hint: 'Enter Note',
                controller: noteController,
              ),
              MyInput(
                title: 'Date',
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                  onPressed: () {
                    getDate();
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInput(
                      title: 'Start Time ',
                      hint: startDate,
                      widget: IconButton(
                        onPressed: () {
                          getTime(true);
                        },
                        icon: const Icon(
                          Icons.alarm,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MyInput(
                      title: 'End Time',
                      hint: endDate,
                      widget: IconButton(
                        onPressed: () {
                          getTime(false);
                        },
                        icon: const Icon(
                          Icons.alarm_add,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              MyInput(
                title: 'Remind',
                hint: '$selectedRemind minutes early ',
                widget: DropdownButton(
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRemind = int.parse(newValue!);
                      });
                    },
                    underline: Container(
                      height: 0,
                    ),
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    items: Reminds.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem(
                          value: value.toString(),
                          child: Text(
                            value.toString(),
                            style: TextStyle(
                              color: Get.isDarkMode ? Colors.white : darkGreyC,
                            ),
                          ));
                    }).toList()),
              ),
              MyInput(
                title: 'Repeat',
                hint: '$selectedRepeat  ',
                widget: DropdownButton(
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRepeat = newValue!;
                      });
                    },
                    underline: Container(
                      height: 0,
                    ),
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    items: Repeat.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem(
                          value: value.toString(),
                          child: Text(
                            value.toString(),
                            style: TextStyle(
                              color: Get.isDarkMode ? Colors.white : darkGreyC,
                            ),
                          ));
                    }).toList()),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "color",
                        style: subTitleStyle,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = 0;
                              });
                            },
                            child: CircleAvatar(
                              radius: 15,
                              child: selectedColor == 0
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : null,
                              backgroundColor: Colors.red,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = 1;
                              });
                            },
                            child: CircleAvatar(
                              radius: 15,
                              child: selectedColor == 1
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : null,
                              backgroundColor: Colors.blueAccent,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = 2;
                              });
                            },
                            child: CircleAvatar(
                              radius: 15,
                              child: selectedColor == 2
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : null,
                              backgroundColor: Colors.purple,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = 3;
                              });
                            },
                            child: CircleAvatar(
                              radius: 15,
                              child: selectedColor == 3
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : null,
                              backgroundColor: Colors.amber,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  MyButtton(
                      label: 'Create Task',
                      onTap: () {
                        validateInput();
                        Get.back();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
