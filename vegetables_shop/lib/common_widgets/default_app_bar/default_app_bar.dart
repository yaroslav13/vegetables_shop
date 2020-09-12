import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget child;

  const DefaultAppBar({Key key, this.child}) : super(key: key);

  DefaultAppBar.fromText(String text)
      : child = Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mantis,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: child,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
