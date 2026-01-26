import 'package:flutter/material.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_bar.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/custom_widgets/app_textfield.dart';

class TaskProgressScreen extends StatelessWidget {
  const TaskProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    List category = ["Engineering", "Completed", "Start Task"];
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: SuperVisorAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.08),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: AppText("TASK NAME: Main Task"),
                      subtitle: Row(
                        children: [
                          AppText("Status:"),
                          AppText("Started", color: AppColors.buttonColor),
                        ],
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: AppText("Due: 18 Aug"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              AppText("Progress"),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: category.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.buttonColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(child: AppText(category[index])),
                      ),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText("Current Assignment", fontSize: 16),
              ),
              GridView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 18/10),
                itemBuilder: (context, index) => 
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.skyColor,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 10,),
                        SizedBox(width: 3,),
                        AppText("Ahmed")
                      ],
                    ),
                  ),
                ),
              ),

              
              SizedBox(height: 10),
              ListTile(
                title: AppText("Time tracking"),
                subtitle: Row(
                  children: [AppText("Starting time: "), AppText("09:00 AM")],
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.skyColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: AppText("End Time", color: AppColors.buttonColor),
                  ),
                ),
              ),CustomTextField(
                isEnable: true,
                textEditingController: controller,
                name: "Add note (optional)",
                isThisFieldRequired: false,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
