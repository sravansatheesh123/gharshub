import 'package:flutter/material.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

import '../../../core/app_colors.dart';

class ViewTaskPage extends StatelessWidget {
  const ViewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyColor,
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(radius: 40),
        ),
        title: AppText("Gharshub", fontSize: 18),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
        backgroundColor: AppColors.whiteColor,
        elevation: 3,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(
              title: AppText("TASK-101190"),
              subtitle: AppText("Due: 18 Aug"),
              trailing: SizedBox(
                width: 130,
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade500,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical:1),
                      child: Center(
                        child: AppText(
                          "In Progess",
                          fontSize: 10,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 6,),
                    Icon(Icons.edit)
                  ],
                ),
              ),
            ),
        
        Divider()
          ],
        ),
      ),
    );
  }
}
