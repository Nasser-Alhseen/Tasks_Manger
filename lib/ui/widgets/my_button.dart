import 'package:flutter/material.dart';
import 'package:flutter_app3/ui/theme.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class MyButtton extends StatelessWidget {
  const MyButtton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.theme.primaryColor,
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
