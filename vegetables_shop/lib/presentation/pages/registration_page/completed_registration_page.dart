import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/presentation/pages/home_screen/home_screen.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

class CompletedRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: AppColors.mantis,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(AppImages.completedRegistration),
              const SizedBox(
                height: 30.0,
              ),
              Text(AppStrings.registrationIsCompleted,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: AppColors.surface,
                      )),
              const Spacer(),
              AnimatedMainButton.fromText(AppStrings.gotoProducts,
                  height: 54.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  textColor: AppColors.mantis,
                  mainColor: AppColors.surface,
                  onTap: () => _navigateToHomeScreen(context)),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToHomeScreen(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ));
}
