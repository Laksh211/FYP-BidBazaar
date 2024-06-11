import 'package:flutter/material.dart';

enum ButtonType {
  outline,
  outlineWithImage,
  text,
  textWithImage,
  image,
  loading,
}

class CustomButton extends StatelessWidget {
  final Color color;
  final bool hasInfiniteWidth;
  final Color textColor;
  final String text;
  final VoidCallback onPressed;
  final Widget? loadingWidget;
  final ButtonType buttonType;

  const CustomButton({
    Key? key,
    required this.color,
    required this.textColor,
    required this.text,
    required this.onPressed,
    required this.hasInfiniteWidth,
    this.loadingWidget,
    this.buttonType = ButtonType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: hasInfiniteWidth ? double.infinity : 0,
      ),
      child: getButtonWidget(context),
    );
  }

  getButtonWidget(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          fontSize: 20.0,
          fontFamily: "Nunito",
        );
    // switch (buttonType) {
    //   case ButtonType.loading:
    //     return buildTextButton(
    //       textStyle: textStyle,
    //       child: loadingWidget == null
    //           ? Text(text, style: textStyle)
    //           : loadingWidget!,
    //     );
    // default:
    return buildTextButton(
      textStyle: textStyle,
      child:
          loadingWidget == null ? Text(text, style: textStyle) : loadingWidget!,
    );
    // }
  }

  TextButton buildTextButton({
    required TextStyle textStyle,
    required Widget child,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
