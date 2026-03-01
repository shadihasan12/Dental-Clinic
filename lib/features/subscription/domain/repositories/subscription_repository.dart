import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';

abstract class SubscriptionRepository {
  Future<Either<NetworkExceptions, List<SubscriptionPlanEntity>>> getPlans();
}
