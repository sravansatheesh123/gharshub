import 'package:flutter/material.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  String? text;
  double? fontSize;

  TextAlign? textAlign;
  Color? color;
  bool? underline;
  FontWeight? fontWeight;
  int? maxLines;
  double? fontheight;
  String? fontFamily;

  AppText(
    this.text, {
    super.key,
    this.fontSize,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.underline = false,
    this.maxLines,
    this.fontheight,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.poppins(
        height: fontheight ?? 1,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize ?? 13,
        color: color ?? AppColors.blackColor,
        decoration: underline! ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
