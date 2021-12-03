// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_app3/services/them_services.dart';
import 'package:flutter_app3/ui/theme.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key, required this.payLoad}) : super(key: key);

  late String payLoad;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late String payLoad;

  @override
  void initState() {
    payLoad = widget.payLoad;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Icon i = ThemeServices().loadTheme()
        ? const Icon(Icons.dark_mode)
        : const Icon(Icons.wb_sunny);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              margin:const  EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.person,
                size: 30,
              ))
        ],
        leading: IconButton(
          icon: i,
          onPressed: () => setState(() {
            ThemeServices().switchTheme();
          }),
        ),
        centerTitle: true,
        title: Text(
          payLoad.toString().split("|")[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    payLoad.toString().split("|")[0],
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      color: Get.isDarkMode ? Colors.white : darkGreyC,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'You Have a reminder !',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Get.isDarkMode ? Colors.white : darkGreyC,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 90),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Get.isDarkMode ? orangeC : bluishC,
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.text_format,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Title",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        payLoad.toString().split("|")[0],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.description,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        payLoad.toString().split("|")[1],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.calendar_today,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        payLoad.toString().split("|")[2],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
