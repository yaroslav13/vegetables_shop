import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vegetable_shop/common_widgets/animated_clip_rect/animated_clip_rect.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

const Duration _kAnimationDuration = Duration(milliseconds: 370);

class ProductDescriptionSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductDescriptionSectionState();
}

class _ProductDescriptionSectionState extends State<ProductDescriptionSection> {
  final ValueNotifier<bool> _expandNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final List<Widget> expansionChildren = _prepareExpansionChildren();
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          const SizedBox(
            height: 110.0,
          ),
          Column(
            children: <Widget>[
              _Title(),
              const SizedBox(
                height: 5.0,
              ),
              AnimatedClipRect(
                notifier: _expandNotifier,
                duration: _kAnimationDuration,
                alignment: Alignment.topCenter,
                horizontalAnimation: false,
                begin: 0.2,
                child: Column(
                  children: expansionChildren,
                ),
              ),
            ],
          ),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _ExpandSheet(
                        expandNotifier: _expandNotifier,
                        onTab: _changeState,
                      ),
                      Divider(
                        thickness: 1.0,
                        color: AppColors.mineShaft.withOpacity(0.2),
                        height: 0.0,
                      )
                    ],
                  )))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _expandNotifier.dispose();
    super.dispose();
  }

  List<Widget> _prepareExpansionChildren() {
    return [
      Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tristique, dui at condimentum dignissim, ligula sem rhoncus nisl, at fringilla purus magna vitae tortor. Proin felis justo, gravida a mattis nec, interdum et mi. Vestibulum mollis erat porta, sodales neque in, ultrices ex. Fusce pellentesque urna in dignissim posuere. Nullam ut nisi malesuada, pretium quam sit amet, sodales nibh. Sed quam nisi, luctus quis laoreet ac, molestie eget est. Cras eros ex, porttitor in bibendum et, tempus eu sem. In diam leo, eleifend non mollis sit amet, aliquet sit amet justo. Nunc pellentesque risus id ligula placerat euismod. Sed id risus in purus elementum ullamcorper ut bibendum magna. Donec eu posuere arcu.',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      const SizedBox(height: 25.0),
    ];
  }

  void _changeState() {
    _expandNotifier.value = !_expandNotifier.value;
  }
}

class _ExpandSheet extends StatelessWidget {
  final VoidCallback onTab;
  final ValueNotifier<bool> expandNotifier;

  const _ExpandSheet(
      {Key key, @required this.onTab, @required this.expandNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTab,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: expandNotifier,
            builder: (_, expanded, child) {
              return AnimatedContainer(
                duration: _kAnimationDuration,
                height: 80.0,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                decoration: expanded
                    ? BoxDecoration()
                    : BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                          colors: [Colors.white.withOpacity(0.0), Colors.white],
                        ),
                      ),
                child: expanded ? const _LessInfo() : const _MoreInfo(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MoreInfo extends StatelessWidget {
  const _MoreInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          AppStrings.moreInfo,
          style: TextStyle(
              color: AppColors.mantis,
              fontWeight: FontWeight.w900,
              fontSize: 12.0),
        ),
        const SizedBox(
          height: 5.0,
        ),
        SvgPicture.asset(
          AppImages.arrowDown,
          color: AppColors.mantis,
          height: 10.0,
          width: 10.0,
        ),
        const SizedBox(
          height: 15.0,
        )
      ],
    );
  }
}

class _LessInfo extends StatelessWidget {
  const _LessInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SvgPicture.asset(
          AppImages.arrowUp,
          color: AppColors.mantis,
          height: 10.0,
          width: 10.0,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          AppStrings.lessInfo,
          style: TextStyle(
              color: AppColors.mantis,
              fontWeight: FontWeight.bold,
              fontSize: 12.0),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Полезная инофрмация о продукте",
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(fontSize: 16.0, color: AppColors.mantis),
    );
  }
}
