import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({required this.message});
}

class GenericFailure extends Failure {
  GenericFailure({required message}) : super(message: message);

  @override
  List<Object?> get props => [super.message];
}

class WebAdapterFailure extends Failure {
  WebAdapterFailure({required String message}) : super(message: message);

  @override
  List<Object?> get props => [super.message];
}

class WebAdapterNoOkFailure extends Failure {
  final int statusCode;
  WebAdapterNoOkFailure(this.statusCode)
      : super(message: 'StatusCode is not 200 OK');

  @override
  List<Object?> get props => [this.statusCode, super.message];
}

class NullArgumentFailure extends Failure {
  NullArgumentFailure() : super(message: 'Null Argument');
  @override
  List<Object?> get props => [super.message];
}
