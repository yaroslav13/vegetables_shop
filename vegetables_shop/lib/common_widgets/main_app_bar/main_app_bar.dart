import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/main_icon_button/main_icon_button.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';

class MainAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() => _MainAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class _MainAppBarState extends State<MainAppBar> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  bool _searchIsActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
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
                      child: MainIcon.fromImage(AppImages.vegetables)),
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

  Widget _searchTextField() {
    if (_searchIsActive) {
      return Container(
        height: 42.0,
        width: 300.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius:  BorderRadius.circular(4.0)),
        child: TextField(
          focusNode: _focusNode,
          controller: _searchController,
          maxLines: 1,
          style: TextStyle(
              fontFamily: 'Como',
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0),
          cursorColor: AppColors.mantis,
          cursorWidth: 1.0,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            filled: true,
            isDense: true,
            labelStyle: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontWeight: FontWeight.w500, fontSize: 16.0),
            hintStyle: TextStyle(
                fontFamily: 'Como',
                color: AppColors.mineShaft.withOpacity(0.5),
                fontSize: 16.0,
                fontWeight: FontWeight.w500),
            fillColor: Colors.white,
            focusColor: Colors.grey.withOpacity(0.4),
            suffixIcon: _ClearSearchButton(
              onTap: () {
                _searchController.clear();
              },
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

class _ClearSearchButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ClearSearchButton({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Icon(Icons.close),
    );
  }
}
