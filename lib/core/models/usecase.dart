import 'package:assist_agro/core/core/core_handler.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<CoreHandle<Type>> call({Params? param});
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
