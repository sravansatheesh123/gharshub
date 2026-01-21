import 'package:flutter/material.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.buttonColor,
        title: AppText("Profile", color: AppColors.whiteColor, fontSize: 16),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 50),
              SizedBox(height: 10),
              AppText("Alex Johnson", fontSize: 16),
              AppText(
                "Technician",
                fontWeight: FontWeight.normal,
                fontheight: 2,
                color: AppColors.buttonColor,
              ),
              AppText(
                "Employee ID: 123456",
                fontWeight: FontWeight.normal,
                fontheight: 1,
              ),
              SizedBox(height: 20),
              reusableListTile(
                icon: Icons.call,
                title: "Mobile Number",
                value: "9090909090",
              ),
              reusableListTile(
                icon: Icons.email,
                title: "Email",
                value: "alex@gmail.com",
              ),
              reusableListTile(
                icon: Icons.local_fire_department,
                title: "Department / Trade",
                value: "Electrical",
              ),
              reusableListTile(
                icon: Icons.task,
                title: "Current Project",
                value: "Project A, Project B",
              ),
              reusableListTile(
                icon: Icons.report,
                title: "Reporting Supervisor",
                value: "Michel Smith",
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText("Preferences", fontSize: 16),
                      SizedBox(height: 15),
                      ListTile(
                        leading: AppText("Notification"),
                        trailing: Switch(
                          value: true,
                          onChanged: (val) {},
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                      ListTile(
                        leading: AppText("Language"),
                        trailing: AppText("English"),
                      ),
                      CustomButton(onTap: () {}, text: "Logout"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  reusableListTile({icon, title, value}) {
    return Column(
      children: [
        ListTile(
          minTileHeight: 30,
          leading: Icon(icon, color: AppColors.buttonColor),
          title: AppText(title ?? ""),
          trailing: AppText(value ?? "", color: AppColors.lightgrayColor),
        ),
        Divider(),
      ],
    );
  }
}
