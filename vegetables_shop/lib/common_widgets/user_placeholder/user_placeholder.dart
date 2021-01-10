import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';

class UserPlaceholder extends StatelessWidget {
  final String imagePath;
  final double height;
  final double weight;

  const UserPlaceholder(
      {Key key, this.imagePath, this.height = 80.0, this.weight = 80.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          height: height,
          width: weight,
          child: FittedBox(
              child: imagePath != null && imagePath.isNotEmpty
                  ? FileImage(File(imagePath))
                  : SvgPicture.asset(AppImages.placeholder)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ));
  }
}
