import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

Future<ImageSource> showSelectImageSourceAlert(
  BuildContext context,
) async {
  var source = await showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(AppStrings.gallery),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pop(ImageSource.gallery);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(AppStrings.camera),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pop(ImageSource.camera);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDestructiveAction: true,
              child: Text(AppStrings.cancel),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ));
  return source;
}
