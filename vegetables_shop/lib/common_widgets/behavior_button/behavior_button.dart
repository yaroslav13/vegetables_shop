import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

class BehaviorNextButton extends StatelessWidget {
  final String text;
  final ValueNotifier<bool> activeButtonNotifier;
  final UpdateCallback onTap;

  const BehaviorNextButton(
      {Key key,
      @required this.activeButtonNotifier,
      @required this.onTap,
      this.text = AppStrings.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: activeButtonNotifier,
      builder: (BuildContext context, isActive, _) {
        return AnimatedMainButton(
          height: 54.0,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,
                  style: TextStyle(
                      fontSize: 14,
                      color: isActive
                          ? AppColors.surface
                          : AppColors.surface.withOpacity(0.6))),
              const SizedBox(width: 5.0),
              Icon(Icons.arrow_forward_ios,
                  color: isActive
                      ? AppColors.surface
                      : AppColors.surface.withOpacity(0.6),
                  size: 14.0),
            ],
          ),
          onTap: isActive ? onTap : null,
        );
      },
    );
  }
}
