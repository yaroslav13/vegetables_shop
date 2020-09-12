import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';

class NewsSection extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;

  const NewsSection(
      {Key key,
      @required this.title,
      this.imagePath,
      @required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(16.0)),
          border: Border.all(color: AppColors.mineShaft, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12.0),
              child: Text(title, style: Theme.of(context).textTheme.subtitle1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Divider(color: AppColors.turquoise),
            ),
            if (imagePath != null)
              SizedBox(
                height: 120.0,
                width: double.infinity,
                child: Image.network(imagePath, fit: BoxFit.cover),
              ),
            if (imagePath != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Divider(color: AppColors.turquoise),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(description,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
      ),
    );
  }
}
