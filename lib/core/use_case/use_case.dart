import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

/// Base use case class for all use cases in the domain layer
///
/// [Entity] - The return type of the use case
/// [Params] - The parameters required by the use case
abstract class UseCase<Entity, Params> {
  Future<Either<NetworkExceptions, Entity>> call(Params params);
}

/// Use this class when a use case doesn't require any parameters
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
