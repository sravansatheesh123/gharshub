import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.buttonColor,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        title: AppText(
          "Notifications",
          color: AppColors.whiteColor,
          fontSize: 16,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 10, // later replace with API list length
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.buttonColor.withOpacity(.1),
                child: Icon(
                  Icons.notifications,
                  color: AppColors.buttonColor,
                ),
              ),
              title: AppText(
                "Notification Title $index",
                fontWeight: FontWeight.bold,
              ),
              subtitle: AppText(
                "This is notification message number $index",
                fontSize: 12,
              ),
              trailing: AppText(
                "2m ago",
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
