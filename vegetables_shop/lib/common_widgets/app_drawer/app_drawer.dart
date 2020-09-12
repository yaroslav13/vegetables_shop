import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegetable_shop/presentation/bloc/app_drawer_bloc/app_drawer_bloc.dart';
import 'package:vegetable_shop/presentation/bloc/base_drawer.dart';
import 'package:vegetable_shop/presentation/pages/news_page/news_page.dart';
import 'package:vegetable_shop/presentation/pages/terms_page/terms_page.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/routes/routes.dart';

class AppDrawer extends BaseDrawer {
  @override
  State<StatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends BaseState<AppDrawer, AppDrawerBloc> {
  @override
  Widget body() => Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.5,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _Placeholder(),
                const Divider(color: AppColors.turquoise),
                _DrawerSections(
                  imagePath: AppImages.news,
                  text: AppStrings.news,
                  onTap: _navigateToNewsPage,
                ),
                _DrawerSections(
                    imagePath: AppImages.telephone,
                    text: AppStrings.telephone,
                    onTap: _launchToCall),
                const Spacer(),
                const _Terms(),
              ],
            ),
          ),
        ),
      );

  @override
  AppDrawerBloc provideBloc() => AppDrawerBloc();

  _launchToCall() async {
    const url = 'tel:+380992926152';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _navigateToNewsPage() =>
      Navigator.of(context).push(SlideRightRoute(page: NewsPage()));
}

class _Placeholder extends StatelessWidget {
  final String imagePath;

  const _Placeholder({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          child: FittedBox(
              child: imagePath != null
                  ? NetworkImage(imagePath)
                  : SvgPicture.asset(AppImages.placeholder)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ));
  }
}

class _DrawerSections extends StatefulWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const _DrawerSections(
      {Key key, @required this.imagePath, @required this.text, this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawerSectionsState();
}

class _DrawerSectionsState extends State<_DrawerSections>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacityAnimation;
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _reverseAnimation();
        }
      });
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.bounceInOut,
      parent: _controller,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: GestureDetector(
            onTap: () => _handleTap(),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(widget.imagePath,
                              height: 20.0,
                              width: 20.0,
                              color: _selected
                                  ? AppColors.lightKhaki
                                  : AppColors.onPrimary),
                          const SizedBox(width: 5.0),
                          Text(widget.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      fontSize: 18,
                                      color: _selected
                                          ? AppColors.lightKhaki
                                          : AppColors.onPrimary)),
                        ],
                      ),
                      Opacity(
                        opacity: _opacityAnimation.value,
                        child: Image.asset(AppImages.rightArrow,
                            width: 20.0,
                            height: 20.0,
                            color: AppColors.lightKhaki),
                      ),
                    ],
                  ),
                  Divider(
                      color: _selected
                          ? AppColors.lightKhaki
                          : AppColors.turquoise)
                ],
              ),
            )));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _forwardAnimation() {
    _selected = true;
    _controller.forward();
  }

  void _reverseAnimation() {
    _selected = false;
    _controller.reverse();
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap();
    }
    _forwardAnimation();
  }
}

class _Terms extends StatelessWidget {
  const _Terms();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: GestureDetector(
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
            )));
  }

  _navigateToTermsPage(BuildContext context) =>
      Navigator.of(context).push(SlideRightRoute(page: TermsPage()));
}
