import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/supervisor/profile_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_bar.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/screen/auth/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupervisorProfilePage extends StatelessWidget {
  SupervisorProfilePage({super.key});
  final spvProfileController = Get.put(SPV_ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: SuperVisorAppBar(),
      ),
      body: spvProfileController.isLoading
          ? Center(child: AppText("Loading"))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.lightgrayColor.withOpacity(.1),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(radius: 50),
                          SizedBox(height: 10),
                          AppText(
                            spvProfileController
                                    .spvProfileModel
                                    ?.data
                                    ?.user
                                    ?.name
                                    ?.toUpperCase() ??
                                "",
                            fontSize: 16,
                          ),
                          AppText(
                            spvProfileController
                                    .spvProfileModel
                                    ?.data
                                    ?.user
                                    ?.role
                                    ?.toUpperCase() ??
                                "",
                            fontWeight: FontWeight.normal,
                            fontheight: 2,
                            color: AppColors.buttonColor,
                          ),
                          AppText(
                            "Employee ID:${spvProfileController.spvProfileModel?.data?.user?.employeeId ?? ""}",
                            fontWeight: FontWeight.normal,
                            fontheight: 1,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    reusableListTile(
                      icon: Icons.call,
                      title: "Mobile Number",
                      value:
                          spvProfileController
                              .spvProfileModel
                              ?.data
                              ?.user
                              ?.phone ??
                          "-",
                    ),
                    reusableListTile(
                      icon: Icons.email,
                      title: "Email",
                      value:
                          spvProfileController
                              .spvProfileModel
                              ?.data
                              ?.user
                              ?.username ??
                          "",
                    ),
                    reusableListTile(
                      icon: Icons.local_fire_department,
                      title: "Department",
                      value:
                          spvProfileController
                              .spvProfileModel
                              ?.data
                              ?.user
                              ?.department ??
                          "",
                    ),

                    // reusableListTile(
                    //   icon: Icons.task,
                    //   title: "Project Assigned",
                    //   value: "5",
                    // ),
                    // ListTile(
                    //   minTileHeight: 30,
                    //   leading: Icon(
                    //     Icons.notifications,
                    //     color: AppColors.buttonColor,
                    //   ),
                    //   title: AppText("Notification"),
                    //   trailing: Switch(
                    //     value: true,
                    //     onChanged: (val) {},
                    //     padding: EdgeInsets.all(10),
                    //   ),
                    // ),
                    // Divider(),
                    reusableListTile(
                      icon: Icons.language,
                      title: "Language",
                      value: "English",
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      onTap: () async {
                        final pref = await SharedPreferences.getInstance();
                        pref.clear();
                        Get.to(LoginPage());
                      },
                      text: "Logout",
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
