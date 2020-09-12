import 'package:vegetable_shop/common_widgets/grid_view_section/grid_view_section.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';

extension BriefDetailsRowExtension on BriefDetailsTypes{
  String get detailsIcon{
    switch(this){
      case BriefDetailsTypes.balance:
        return AppImages.balance;
      case BriefDetailsTypes.price:
        return AppImages.dollar;
      case BriefDetailsTypes.country:
        return AppImages.country;
      default:
        throw Exception('Undefined type');
    }
  }
}