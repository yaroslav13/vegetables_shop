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

  const InputField(
      {Key key,
      @required this.height,
      @required this.width,
      this.focusNode,
      @required this.controller,
      this.suffixIcon,
      this.textInputFormatterList})
      : super(key: key);

  InputField.fromClearButtonSuffixIcon(
      {this.height,
      this.width,
      this.focusNode,
      bool displayClearButton,
      this.controller,
      this.textInputFormatterList})
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
        maxLines: 1,
        style: TextStyle(
            fontFamily: 'Como',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.0),
        cursorColor: AppColors.mantis,
        cursorWidth: 1.0,
        inputFormatters: textInputFormatterList,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            filled: true,
            isDense: true,
            labelStyle: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontWeight: FontWeight.w500, fontSize: 16.0),
            hintStyle: TextStyle(
                fontFamily: 'Como',
                color: AppColors.mineShaft.withOpacity(0.5),
                fontSize: 16.0,
                fontWeight: FontWeight.w500),
            fillColor: Colors.white,
            focusColor: Colors.grey.withOpacity(0.4),
            suffixIcon: suffixIcon),
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
