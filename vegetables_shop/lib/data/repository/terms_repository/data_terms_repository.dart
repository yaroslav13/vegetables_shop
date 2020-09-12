import 'package:flutter/services.dart';
import 'package:vegetable_shop/data/repository/terms_repository/terms_repository.dart';

class DataTermsRepository implements TermsRepository {
  String _path = 'html/terms.html';

  @override
  Future<String> getTerms() async {
    return await rootBundle.loadString(_path, cache: true);
  }
}
