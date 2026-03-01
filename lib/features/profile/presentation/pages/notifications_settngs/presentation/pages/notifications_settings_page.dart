import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_card.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/presentation/manager/notification_settings_bloc.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/presentation/widgets/notification_settings_tile.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NotificationsSettingsPage extends StatelessWidget {
  const NotificationsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationSettingsBloc>()
        ..add(const NotificationSettingsEvent.loadSettings()),
      child: const _NotificationsSettingsContent(),
    );
  }
}

class _NotificationsSettingsContent extends StatelessWidget {
  const _NotificationsSettingsContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          PageHeader(
            title: l10n.notificationsSettings,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: BlocBuilder<NotificationSettingsBloc,
                NotificationSettingsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (message) => Center(child: Text(message)),
                  loaded: (settings) => _buildContent(context, l10n, settings),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _toggle(
    BuildContext context,
    NotificationSettingsEntity updated,
  ) {
    context.read<NotificationSettingsBloc>().add(
          NotificationSettingsEvent.updateSettings(updated),
        );
  }

  Widget _buildContent(
    BuildContext context,
    AppLocalizations l10n,
    NotificationSettingsEntity settings,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Reminders ─────────────────────────────────────────
          _SectionLabel(label: l10n.reminders),
          SizedBox(height: 8.h),
          CustomCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                NotificationSettingsTile(
                  icon: Icons.calendar_month_outlined,
                  iconColor: ColorManager.primary,
                  title: l10n.appointmentReminders,
                  subtitle: l10n.appointmentRemindersDesc,
                  value: settings.appointmentReminders,
                  onChanged: (v) => _toggle(
                    context,
                    settings.copyWith(appointmentReminders: v),
                  ),
                  showDivider: true,
                ),
                NotificationSettingsTile(
                  icon: Icons.receipt_long_outlined,
                  iconColor: ColorManager.warning,
                  title: l10n.paymentReminders,
                  subtitle: l10n.paymentRemindersDesc,
                  value: settings.paymentReminders,
                  onChanged: (v) => _toggle(
                    context,
                    settings.copyWith(paymentReminders: v),
                  ),
                  showDivider: true,
                ),
                NotificationSettingsTile(
                  icon: Icons.person_search_outlined,
                  iconColor: ColorManager.info,
                  title: l10n.patientFollowUp,
                  subtitle: l10n.patientFollowUpDesc,
                  value: settings.patientFollowUp,
                  onChanged: (v) => _toggle(
                    context,
                    settings.copyWith(patientFollowUp: v),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // ── Updates ───────────────────────────────────────────
          _SectionLabel(label: l10n.updates),
          SizedBox(height: 8.h),
          CustomCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                NotificationSettingsTile(
                  icon: Icons.newspaper_outlined,
                  iconColor: ColorManager.purple,
                  title: l10n.newsAndUpdates,
                  subtitle: l10n.newsAndUpdatesDesc,
                  value: settings.newsAndUpdates,
                  onChanged: (v) => _toggle(
                    context,
                    settings.copyWith(newsAndUpdates: v),
                  ),
                  showDivider: true,
                ),
                NotificationSettingsTile(
                  icon: Icons.auto_awesome_outlined,
                  iconColor: ColorManager.secondary,
                  title: l10n.newFeatures,
                  subtitle: l10n.newFeaturesDesc,
                  value: settings.newFeatures,
                  onChanged: (v) => _toggle(
                    context,
                    settings.copyWith(newFeatures: v),
                  ),
                  showDivider: true,
                ),
                NotificationSettingsTile(
                  icon: Icons.local_offer_outlined,
                  iconColor: ColorManager.error,
                  title: l10n.promotionalOffers,
                  subtitle: l10n.promotionalOffersDesc,
                  value: settings.promotionalOffers,
                  onChanged: (v) => _toggle(
                    context,
                    settings.copyWith(promotionalOffers: v),
                  ),
                  showDivider: true,
                ),
                NotificationSettingsTile(
                  icon: Icons.bar_chart_rounded,
                  iconColor: ColorManager.info,
                  title: l10n.statisticsUpdates,
                  subtitle: l10n.statisticsUpdatesDesc,
                  value: settings.statisticsUpdates,
                  onChanged: (v) => _toggle(
                    context,
                    settings.copyWith(statisticsUpdates: v),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // ── Communication ─────────────────────────────────────
          _SectionLabel(label: l10n.communication),
          SizedBox(height: 8.h),
          CustomCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                NotificationSettingsTile(
                  icon: Icons.notifications_outlined,
                  iconColor: ColorManager.primary,
                  title: l10n.pushNotifications,
                  subtitle: l10n.pushNotificationsDesc,
                  value: settings.pushNotifications,
                  onChanged: (v) => _toggle(
                    context,
                    settings.copyWith(pushNotifications: v),
                  ),
                  showDivider: true,
                ),
                NotificationSettingsTile(
                  icon: Icons.email_outlined,
                  iconColor: ColorManager.info,
                  title: l10n.emailNotifications,
                  subtitle: l10n.emailNotificationsDesc,
                  value: settings.emailNotifications,
                  onChanged: (v) => _toggle(
                    context,
                    settings.copyWith(emailNotifications: v),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

// ─── Section Label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w600,
          color: ColorManager.textTertiary,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
