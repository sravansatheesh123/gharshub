import 'package:flutter/material.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

class CustomTextField extends StatelessWidget {
  bool isThisFieldRequired;

  TextEditingController textEditingController;
  String name;
  String? title;
  TextInputType? keyboardType;
  IconData? icon;
  Widget? suffixIcon, prefixIcon;
  bool? obscureText = false;
  bool? isEnable = false;
  int? maxLines;
  CustomTextField({
    required this.textEditingController,
    required this.name,
    required this.isThisFieldRequired,
    this.suffixIcon,
    this.keyboardType,
    this.icon,
    this.obscureText,
    this.title,
    this.prefixIcon,
    this.maxLines,
    this.isEnable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isEnable == false
            ? Row(
                children: [
                  AppText(title, fontSize: 14, color: AppColors.lightgrayColor),
                  Text("  *", style: TextStyle(color: AppColors.redColor)),
                ],
              )
            : Container(),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: obscureText == true ? true : false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: textEditingController,
          validator: (value) {
            if (isThisFieldRequired) {
              if (value!.isEmpty) {
                return 'Enter the $name';
              }
              return null;
            } else {
              return null;
            }
          },
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 5,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(color: Colors.red),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(color: AppColors.buttonColor),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: "$name",
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
