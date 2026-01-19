import 'package:flutter/material.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.width,
    this.height,
    required this.onTap,
    this.text,
    this.color,
    this.textColor,
    this.textSize,
    this.isLoader,
  });
  final double? height, width;
  final String? text;
  final double? textSize;
  final Function()? onTap;
  final Color? color, textColor;
  final bool? isLoader;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: width ?? double.infinity,
      height: height ?? 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: color ?? AppColors.buttonColor,
      child: isLoader == true
          ? SizedBox(
              height: 25,
              width: 25,
              child: LoadingAnimationWidget.inkDrop(
                color: AppColors.whiteColor,
                size: 24,
              ),
            )
          : AppText(
              text,
              fontSize: textSize ?? 14,
              fontWeight: FontWeight.w600,
              fontheight: 1.5,
              color: textColor ?? AppColors.whiteColor,
            ),
    );
  }
}
