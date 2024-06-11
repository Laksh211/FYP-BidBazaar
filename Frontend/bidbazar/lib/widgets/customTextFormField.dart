import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {
  const customTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIconData,
    this.suffixIconData,
    this.autofocus,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.obscureText,
    this.onSuffixTap,
  });

  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool? autofocus;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final void Function()? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        // contentPadding:Theme.of(context).inputDecorationTheme.contentPadding,
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIconData),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 10.0,
        ),
        suffixIcon: suffixIconData != null
            ? InkWell(
                onTap: onSuffixTap,
                child: Icon(
                  suffixIconData,
                  size: 20,
                ),
              )
            : null,
      ),
      autofocus: autofocus ?? true,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      validator: validator,
      // validator: (value) {},
    );
  }
}
