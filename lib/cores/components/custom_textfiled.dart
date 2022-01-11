import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cores/constants/color.dart';
import '../../cores/utils/sizer_utils.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.textEditingController,
    this.autoCorrect = true,
    required this.hintText,
    // required this.labelText,
    this.validator,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.maxLine = 1,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final bool autoCorrect;
  final String hintText;
  // final String labelText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final TextInputType textInputType;
  final bool isPassword;
  final int? maxLine;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (BuildContext context, bool value, dynamic child) {
        return TextFormField(
          maxLines: widget.maxLine,
          cursorColor: kcPrimaryColor,
          style: GoogleFonts.raleway(),
          controller: widget.textEditingController,
          autocorrect: widget.autoCorrect,
          autovalidateMode: widget.validator != null
              ? AutovalidateMode.onUserInteraction
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(sizerSp(15.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(sizerSp(15.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(sizerSp(15.0)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(sizerSp(15.0)),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w600,
            ),
            suffixIcon: widget.isPassword == false
                ? const SizedBox()
                : IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () => obscureText.value = !obscureText.value,
                  ),
          ),
          keyboardType: widget.textInputType,
          obscureText: value,
          validator: (String? val) => widget.validator!(val?.trim()),
          onChanged: (String? val) {
            if (widget.onChanged == null) return;
            widget.onChanged!(val?.trim());
          },
        );
      },
    );
  }
}
