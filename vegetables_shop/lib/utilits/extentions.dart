import 'package:vegetable_shop/common_widgets/grid_view_section/grid_view_section.dart';
import 'package:vegetable_shop/presentation/pages/cart_page/card_view.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

enum UnitTypes { kg, gram }
enum VitaminEnum { A, B, C }
enum Nutrients { carbohydrates, proteins, fats }

const defaultValueForKgUnits = 1000;
const defaultValueForGramUnits = 100;

extension BriefDetailsRowExtension on BriefDetailsTypes {
  String get detailsIcon {
    switch (this) {
      case BriefDetailsTypes.balance:
        return AppImages.balance;
      case BriefDetailsTypes.price:
        return AppImages.dollar;
      case BriefDetailsTypes.country:
        return AppImages.country;
      case BriefDetailsTypes.packaged:
        return AppImages.packaged;
      default:
        throw Exception('Undefined type of brief details');
    }
  }
}

extension UnitTypesExtension on UnitTypes {
  String get getUnit {
    switch (this) {
      case UnitTypes.kg:
        return AppStrings.pricePerKg;
      case UnitTypes.gram:
        return AppStrings.pricePerHundredGram;
      default:
        throw Exception('Undefined type of units');
    }
  }

  int get getDefaultValues {
    switch (this) {
      case UnitTypes.kg:
        return defaultValueForKgUnits;
      case UnitTypes.gram:
        return defaultValueForGramUnits;
      default:
        throw Exception('Undefined type of units');
    }
  }
}

extension PaymentCardTypeExtension on PaymentCardTypes {
  String get getPaymentCardIcon {
    switch (this) {
      case PaymentCardTypes.mastercard:
        return AppImages.iconMasterCard;
      case PaymentCardTypes.visa:
        return AppImages.iconVisa;
      default:
        return AppImages.iconPaymentCardDefault;
    }
  }
}

extension StringExtension on String {
  String get capitalize {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension VitaminEnumExtentions on VitaminEnum {
  String get getVitaminName {
    switch (this) {
      case VitaminEnum.A:
        return AppStrings.vitaminA;
      case VitaminEnum.B:
        return AppStrings.vitaminB;
      case VitaminEnum.C:
        return AppStrings.vitaminC;
      default:
        throw Exception('Undefined type of vitamin');
    }
  }
}

extension NutrientsEnumExtentions on Nutrients {
  String get getNutrientsName {
    switch (this) {
      case Nutrients.carbohydrates:
        return 'carbohydrates';
      case Nutrients.proteins:
        return 'proteins';
      case Nutrients.fats:
        return 'fats';
      default:
        throw Exception('Undefined type of nutrients');
    }
  }
}

