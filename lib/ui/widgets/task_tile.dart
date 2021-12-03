import 'package:flutter/material.dart';
import 'package:flutter_app3/models/task.dart';
import 'package:flutter_app3/ui/size_config.dart';
import 'package:flutter_app3/ui/theme.dart';
import 'package:get/get.dart';

class MyTile extends StatelessWidget {
  MyTile({required this.myTask, Key? key}) : super(key: key);
   Task? myTask;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Color getcolor(Task myTask) {
      switch (myTask.color) {
        case 0:
          return Colors.red;
        case 1:
          return Colors.blueAccent;
        case 2:
          return Colors.purple;
        case 3:
          return Colors.amber;
        default:
          return bluishC;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig().getScreenWidth(
            SizeConfig.screenOrientation == Orientation.landscape ? 2 : 12),
      ),
      child: Container(
        width: SizeConfig.screenOrientation == Orientation.landscape
            ? SizeConfig.screeWidth / 2
            : SizeConfig.screeWidth,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: getcolor(myTask!)),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        myTask!.title!,
                        style: titleStyle.copyWith(
                            color: whiteC, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${myTask!.startTime} - ${myTask!.endTime}',
                            style: subHeading.copyWith(color:whiteC)
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        myTask!.note!,
                        style: heading.copyWith(fontSize: 16,fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 1,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                color: Get.isDarkMode ? whiteC : darkGreyC,
              ),
              RotatedBox(
                quarterTurns: 1,
                child: Text(
                  myTask!.isCompleted == 1 ? 'Completed' : 'On Going',
                  style: subHeading.copyWith(color:whiteC)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
