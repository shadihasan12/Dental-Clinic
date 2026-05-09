import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

/// Localized accessors for subscription plan content.
///
/// Plan name/description/features live in English on the static
/// [SubscriptionPlanEntity] (used by data-layer fallbacks, logging, etc.).
/// The pricing UI reads them through this helper instead so labels follow
/// the active locale.
class PricingL10n {
  PricingL10n._();

  static String name(AppLocalizations l10n, PlanTier tier) {
    switch (tier) {
      case PlanTier.solo:
        return l10n.planSoloName;
      case PlanTier.duo:
        return l10n.planDuoName;
      case PlanTier.clinic:
        return l10n.planClinicName;
      case PlanTier.practice:
        return l10n.planPracticeName;
      case PlanTier.custom:
        return l10n.planCustomName;
      case PlanTier.trial:
        // Trial users see Clinic-tier features, so reuse that name.
        return l10n.planClinicName;
    }
  }

  static String description(AppLocalizations l10n, PlanTier tier) {
    switch (tier) {
      case PlanTier.solo:
        return l10n.planSoloDescription;
      case PlanTier.duo:
        return l10n.planDuoDescription;
      case PlanTier.clinic:
        return l10n.planClinicDescription;
      case PlanTier.practice:
        return l10n.planPracticeDescription;
      case PlanTier.custom:
        return l10n.planCustomDescription;
      case PlanTier.trial:
        return l10n.planClinicDescription;
    }
  }

  static List<String> features(AppLocalizations l10n, PlanTier tier) {
    switch (tier) {
      case PlanTier.solo:
        return [
          l10n.planSoloFeature1,
          l10n.planSoloFeature2,
          l10n.planSoloFeature3,
          l10n.planSoloFeature4,
          l10n.planSoloFeature5,
          l10n.planSoloFeature6,
          l10n.planSoloFeature7,
          l10n.planSoloFeature8,
          l10n.planSoloFeature9,
        ];
      case PlanTier.duo:
        // First bullet rolls up Solo's feature set; the rest are the
        // additions specific to Duo.
        return [
          l10n.planEverythingInPlus(l10n.planSoloName),
          l10n.planDuoFeature1,
          l10n.planDuoFeature2,
          l10n.planDuoFeature3,
          l10n.planDuoFeature4,
          l10n.planDuoFeature5,
        ];
      case PlanTier.clinic:
      case PlanTier.trial:
        return [
          l10n.planClinicFeature1,
          l10n.planClinicFeature2,
          l10n.planClinicFeature3,
          l10n.planClinicFeature4,
          l10n.planClinicFeature5,
          l10n.planClinicFeature6,
          l10n.planClinicFeature7,
          l10n.planClinicFeature8,
          l10n.planClinicFeature9,
          l10n.planClinicFeature10,
          l10n.planClinicFeature11,
          l10n.planClinicFeature12,
          l10n.planClinicFeature13,
        ];
      case PlanTier.practice:
        // First bullet rolls up Clinic's feature set; the rest are the
        // additions specific to Practice.
        return [
          l10n.planEverythingInPlus(l10n.planClinicName),
          l10n.planPracticeFeature1,
          l10n.planPracticeFeature2,
          l10n.planPracticeFeature3,
          l10n.planPracticeFeature4,
          l10n.planPracticeFeature5,
          l10n.planPracticeFeature6,
        ];
      case PlanTier.custom:
        return [
          l10n.planCustomFeature1,
          l10n.planCustomFeature2,
          l10n.planCustomFeature3,
          l10n.planCustomFeature4,
          l10n.planCustomFeature5,
          l10n.planCustomFeature6,
          l10n.planCustomFeature7,
          l10n.planCustomFeature8,
        ];
    }
  }
}
