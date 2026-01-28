import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/profile/profile_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileCtlr = Get.put(ProfileController());
  @override
  void initState() {
    profileCtlr.profile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          backgroundColor: AppColors.buttonColor,
          title: AppText("Profile", color: AppColors.whiteColor, fontSize: 16),
          centerTitle: true,
        ),
        body: controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child:
                            controller.profileModel?.data?.user?.profileImage ==
                                null
                            ? Icon(Icons.person)
                            : Container(),
                      ),
                      SizedBox(height: 10),
                      AppText(
                        controller.profileModel?.data?.user?.name ?? "",
                        fontSize: 16,
                      ),
                      AppText(
                        controller.profileModel?.data?.user?.role ?? "",
                        fontWeight: FontWeight.normal,
                        fontheight: 2,
                        color: AppColors.buttonColor,
                      ),
                      AppText(
                        "Employee ID: ${controller.profileModel?.data?.user?.employeeId ?? ""}",
                        fontWeight: FontWeight.normal,
                        fontheight: 1,
                      ),
                      SizedBox(height: 20),
                      reusableListTile(
                        icon: Icons.call,
                        title: "Mobile Number",
                        value:
                            "${controller.profileModel?.data?.user?.phone ?? ""}",
                      ),
                      reusableListTile(
                        icon: Icons.email,
                        title: "Email",
                        value:
                            "${controller.profileModel?.data?.user?.username ?? ""}",
                      ),
                      reusableListTile(
                        icon: Icons.local_fire_department,
                        title: "Department / Trade",
                        value:
                            controller.profileModel?.data?.user?.department ??
                            "",
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
