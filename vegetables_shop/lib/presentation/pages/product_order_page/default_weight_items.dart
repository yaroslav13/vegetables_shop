import 'package:flutter/material.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';

class DefaultWeightBubbles extends StatelessWidget {
  final DefaultWeightItems defaultWeightItems;
  final VoidCallback onTap;
  final bool isDisplayed;

  const DefaultWeightBubbles(
      {Key key, this.defaultWeightItems, this.onTap, this.isDisplayed = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDisplayed) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          child: Container(
            width: 80.0,
            decoration: BoxDecoration(
                color: AppColors.mantis.withOpacity(0.5),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(25.0),
                )),
            child: Center(
              child: Text(defaultWeightItems.grams,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white)),
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

class DefaultWeightItems {
  final String grams;

  DefaultWeightItems(this.grams);
}
