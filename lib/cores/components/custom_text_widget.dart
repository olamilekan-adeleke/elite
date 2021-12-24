import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cores/constants/color.dart';
import '../../cores/constants/font_size.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
    this.text, {
    Key? key,
    this.fontSize = kfsMeduim,
    this.textColor = kcTextColor,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.signikaNegative(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      overflow: overflow,
      softWrap: true,
      maxLines: maxLines,
    );
  }
}
