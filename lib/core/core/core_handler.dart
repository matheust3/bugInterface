import 'package:assist_agro/core/errors/failures.dart';

class CoreHandle<Type> {
  Failure? _failure;
  Type? _response;
  bool _hasFailure = false;
  bool get hasFailure => this._hasFailure;
  Failure? get failure => this._failure;
  Type? get response => this._response;

  CoreHandle({Failure? failure, Type? response}) {
    if (failure != null) {
      this._failure = failure;
      this._hasFailure = true;
    } else if (response != null) {
      this._response = response;
    } else {
      throw ArgumentError('Handle needs failure or response');
    }
  }
}
