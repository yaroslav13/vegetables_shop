import 'package:flutter/material.dart';
import 'package:vegetable_shop/presentation/pages/terms_page/terms_page.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/routes/routes.dart';

class Terms extends StatelessWidget {
  const Terms();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () => _navigateToTermsPage(context),
            child: Text(
              AppStrings.terms,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.mantis.withOpacity(0.5),
                  decorationThickness: 6.0),
            ));
  }

  _navigateToTermsPage(BuildContext context) =>
      Navigator.of(context).push(SlideRightRoute(page: TermsPage()));
}
