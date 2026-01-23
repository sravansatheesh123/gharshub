import 'package:flutter/material.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

class SuperVisorAppBar extends StatelessWidget {
  const SuperVisorAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(radius: 40),
      ),
      title: AppText("Gharshub", fontSize: 18),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
      ],
      backgroundColor: AppColors.whiteColor,
      elevation: 3,
    );
  }
}
