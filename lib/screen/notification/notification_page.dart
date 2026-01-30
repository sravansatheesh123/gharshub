import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:gharshub/controller/dashboard/dashboard_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      id: "",
      builder: (controller) => 
      Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.blackColor),
          title: AppText("Notifications"),
        ),
        body: Column(
          children: [
            ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                width: double.infinity,
                color: AppColors.whiteColor,
                child: ListTile(
                  leading: Icon(Icons.notifications,color: AppColors.buttonColor,),
                  title: AppText("${controller.latestLeave.value?.status}",color: AppColors.buttonColor,),
                  subtitle: AppText("time updated"),
                  trailing: AppText("${controller.latestLeave.value?.updatedAt}"),
                ),
              ),)
          ],
        ),
      ),
    );
  }
}