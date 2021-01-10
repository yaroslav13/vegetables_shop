import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

Future<void> showMainAlert(
  BuildContext context, {
  @required String imagePath,
  @required String body,
  @required Color textColor,
  bool rootNavigator = true,
}) =>
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          color: AppColors.iron.withOpacity(0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12.0,
              ),
              Image.asset(imagePath, height: 50.0, width: 50.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Text(body,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: textColor)),
              ),
              Container(
                height: 50.0,
                color: Colors.white,
                child: IntrinsicHeight(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: rootNavigator).pop();
                    },
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Text(AppStrings.ok,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: textColor)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
