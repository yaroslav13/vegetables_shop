import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  final _errorSubject = PublishSubject<Object>();

  final _loadingIndicator = BehaviorSubject<bool>();

  Sink<dynamic> get errorSink => _errorSubject.sink;

  Stream<dynamic> get errorStream => _errorSubject.stream;

  Sink<bool> get loadingSink => _loadingIndicator.sink;

  Stream<bool> get loadingStream => _loadingIndicator.stream;

  void dispatchError(error) {
    if (!_errorSubject.isClosed) {
      errorSink.add(error);
    }
  }

  void init() {}

  void dispose() {
    _errorSubject.close();
    _loadingIndicator.close();
  }
}
