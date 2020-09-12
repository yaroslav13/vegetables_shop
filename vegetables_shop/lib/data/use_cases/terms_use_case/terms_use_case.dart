import 'package:vegetable_shop/data/repository/terms_repository/data_terms_repository.dart';
import 'package:vegetable_shop/data/repository/terms_repository/terms_repository.dart';

class TermsUseCase {
  final TermsRepository _repository;

  TermsUseCase() : _repository = DataTermsRepository();

  Future<String> getTerms() => _repository.getTerms();
}
