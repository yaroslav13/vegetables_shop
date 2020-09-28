import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';

class InputField extends StatelessWidget {
  final double height;
  final double width;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Widget suffixIcon;
  final List<TextInputFormatter> textInputFormatterList;
  final bool obscureText;
  final Widget prefixIcon;
  final String hintText;
  final TextStyle hintStyle;
  final Color fillColor;
  final TextStyle textFieldStyle;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final EdgeInsetsGeometry contentPadding;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final bool enabled;
  final bool readOnly;

  const InputField(
      {Key key,
      this.height,
      this.width,
      this.focusNode,
      @required this.controller,
      this.suffixIcon,
      this.textInputFormatterList,
      this.obscureText = false,
      this.prefixIcon,
      this.hintText,
      this.hintStyle,
      this.fillColor = Colors.white,
      this.textFieldStyle,
      this.textInputAction,
      this.textAlign = TextAlign.start,
      this.contentPadding,
      this.onSubmitted,
      this.onChanged, this.keyboardType, this.enabled = true, this.readOnly = false})
      : super(key: key);

  InputField.fromClearButtonSuffixIcon(
      {bool displayClearButton,
      this.height,
      this.width,
      this.focusNode,
      this.controller,
      this.textInputFormatterList,
      this.obscureText = false,
      this.prefixIcon,
      this.hintText,
      this.hintStyle,
      this.fillColor = Colors.white,
      this.textFieldStyle,
      this.textInputAction,
      this.textAlign = TextAlign.start,
      this.contentPadding,
      this.onSubmitted,
      this.onChanged, this.keyboardType, this.enabled = true, this.readOnly = false})
      : suffixIcon = displayClearButton
            ? _ClearSearchButton(
                onTap: () {
                  controller.clear();
                },
              )
            : null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        enabled: enabled,
        obscureText: obscureText,
        maxLines: 1,
        readOnly: readOnly,
        textAlign: textAlign,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        onSubmitted: (String value) {
          onSubmitted(value);
        },
        onChanged: (String value) {
          onChanged(value);
        },
        style: textFieldStyle ??
            TextStyle(
                fontFamily: 'Como',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
        cursorColor: AppColors.mantis,
        cursorWidth: 1.0,
        inputFormatters: textInputFormatterList,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          alignLabelWithHint: true,
          filled: true,
          isDense: true,
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                  fontFamily: 'Como',
                  color: AppColors.mineShaft.withOpacity(0.5),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
          fillColor: fillColor,
          focusColor: Colors.grey.withOpacity(0.4),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}

class _ClearSearchButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ClearSearchButton({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: const Icon(Icons.close),
    );
  }
}
