import 'package:flutter/material.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

import '../../../core/app_colors.dart';

class DashBoardWidget extends StatelessWidget {
  const DashBoardWidget({
    super.key,
    this.title,
    this.subTitle,
    this.subTitleValue,
    this.widget,
    this.isEnable,
  });
  final String? title;
  final String? subTitle;
  final String? subTitleValue;
  final Widget? widget;
  final bool? isEnable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              title ?? "",
              fontSize: 16,
              fontheight: 2,
              fontWeight: FontWeight.bold,
              color: AppColors.buttonColor,
            ),
            isEnable == true
                ? reusableRowTile(subTitle ?? "", subTitleValue ?? "")
                : Container(),
            widget ?? Container(),
          ],
        ),
      ),
    );
  }
}

reusableRowTile(subTitle, value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      AppText(subTitle ?? "", fontheight: 2, fontWeight: FontWeight.bold),
      SizedBox(width: 5),
      AppText(value ?? "", fontheight: 2),
    ],
  );
}