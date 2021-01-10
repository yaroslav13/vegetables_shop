import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';

class ErrorParser extends StatelessWidget {
  final ValueNotifier<String> errorParser;

  const ErrorParser({Key key, this.errorParser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, top: 5.0),
            child: ValueListenableBuilder(
                valueListenable: errorParser,
                builder: (BuildContext context, errorText, _) {
                  return Text(errorText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: AppColors.coral));
                })));
  }
}
