import 'package:vegetable_shop/data/use_cases/terms_use_case/terms_use_case.dart';

import '../base_bloc.dart';

class TermsBloc extends BaseBloc {
  final TermsUseCase _useCase = TermsUseCase();

  Future<String> getTerms() => _useCase.getTerms();
}
