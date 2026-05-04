import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';

abstract class SubscriptionRepository {
  Future<Either<NetworkExceptions, List<SubscriptionPlanEntity>>> getPlans();

  Future<Either<NetworkExceptions, SubscriptionStatusEntity>> getStatus();

  Future<Either<NetworkExceptions, SubscriptionUsageEntity>> getUsage();
}
