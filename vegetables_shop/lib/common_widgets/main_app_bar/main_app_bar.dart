import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/common_widgets/main_icon_button/main_icon_button.dart';
import 'package:vegetable_shop/presentation/pages/cart_page/cart_page.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';

class MainAppBar extends StatefulWidget with PreferredSizeWidget {
  final TextEditingController searchController;

  const MainAppBar({Key key, @required this.searchController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class _MainAppBarState extends State<MainAppBar> {
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _searchControllerIsNotEmpty =
      ValueNotifier<bool>(false);

  bool _searchIsActive = false;

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_controllerTextListener);
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: Container(
        height: double.infinity,
        color: AppColors.mantis,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MainIcon.fromIcon(Icons.menu, onTap: () {
                Scaffold.of(context).openDrawer();
              }),
              _searchTextField(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                      visible: !_searchIsActive,
                      child: MainIcon.fromImage(AppImages.vegetables,
                          onTap: _navigateToCartPage)),
                  MainIcon.fromIcon(Icons.search, onTap: () {
                    setState(() {
                      _searchIsActive = !_searchIsActive;
                    });
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchControllerIsNotEmpty.dispose();
    super.dispose();
  }

  Widget _searchTextField() {
    if (_searchIsActive) {
      return ValueListenableBuilder<bool>(
        valueListenable: _searchControllerIsNotEmpty,
        builder: (BuildContext context, controllerIsNotEmpty, _) {
          return Expanded(
            child: InputField.fromClearButtonSuffixIcon(
              height: 42.0,
              controller: widget.searchController,
              focusNode: _focusNode,
              displayClearButton: controllerIsNotEmpty,
            ),
          );
        },
      );
    } else {
      return SizedBox.shrink();
    }
  }

  _navigateToCartPage() => Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => CartPage(),
      ));

  void _controllerTextListener() {
    _searchControllerIsNotEmpty.value = widget.searchController.text.isNotEmpty;
  }
}
