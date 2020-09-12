import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainIcon extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const MainIcon({Key key, this.onTap, this.child}) : super(key: key);

  MainIcon.fromIcon(IconData data, {this.onTap})
      : child = Icon(data, color: Colors.black.withOpacity(0.7), size: 40.0);

  MainIcon.fromImage(String path, {this.onTap})
      : child = Image.asset(path,
            height: 40.0, width: 40.0, color: Colors.black.withOpacity(0.7));

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: GestureDetector(
          onTap: _handleTap,
          child: child,
        ));
  }

  void _handleTap() {
    if (onTap != null) {
      onTap();
    }
  }
}
