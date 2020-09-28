import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/address_profile_information_page.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/card_profile_information_page.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/create_password_page.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/main_profile_information_page.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

import '../../../common_widgets/default_app_bar/default_app_bar.dart';
import '../../bloc/base_screen.dart';
import '../../resources/app_colors.dart';

const int pageCount = 4;
const int initialPage = 0;
const Size carouselDotSize = Size(10, 12);
const Duration transitionDuration = Duration(microseconds: 270);
const Curve transitionCurve = Curves.bounceInOut;
const double dotHorizontalPadding = 12.0;

class RegistrationPage extends BaseScreen {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState
    extends BaseState<RegistrationPage, RegistrationBloc> {
  PageController _pageViewController;

  double _currentPage = 0.0;

  List<String> _stepsCount = [
    AppStrings.step1,
    AppStrings.step2,
    AppStrings.step3,
    AppStrings.step4
  ];

  @override
  void initState() {
    super.initState();
    _pageViewController =
        PageController(initialPage: initialPage, keepPage: false);
  }

  @override
  PreferredSizeWidget appBar() =>
      DefaultAppBar.fromText(AppStrings.registration);

  @override
  Widget body() => SafeArea(
        child: Stack(
          children: [
            _dotsIndicator(),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: PageView(
                controller: _pageViewController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MainProfileInformationPage(
                    pageController: _pageViewController,
                  ),
                  AddressProfileInformationPage(
                    pageController: _pageViewController,
                  ),
                  CardProfileInformationPage(
                    pageController: _pageViewController,
                  ),
                  CreatePasswordPage(),
                ],
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page.toDouble();
                  });
                },
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  RegistrationBloc provideBloc() => RegistrationBloc();

  Align _dotsIndicator() => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DotsIndicator(
                dotsCount: pageCount,
                position: _currentPage,
                decorator: DotsDecorator(
                  size: carouselDotSize,
                  activeSize: carouselDotSize,
                  activeColor: AppColors.mantis,
                  color: AppColors.mantis.withOpacity(0.3),
                  spacing: const EdgeInsets.symmetric(
                      horizontal: dotHorizontalPadding),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    itemCount: _stepsCount.length,
                    itemBuilder: (BuildContext context, int i) {
                      if (_currentPage == i.toDouble()) {
                        return Text(_stepsCount[i],
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: AppColors.mantis,
                                      fontSize: 14.0,
                                    ));
                      } else {
                        const double horizontalPaddingBetweenTwoDots =
                            dotHorizontalPadding * 2;
                        final double spaceBetweenTwoDots =
                            horizontalPaddingBetweenTwoDots +
                                carouselDotSize.width;
                        return SizedBox(
                          width: spaceBetweenTwoDots,
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      );
}
