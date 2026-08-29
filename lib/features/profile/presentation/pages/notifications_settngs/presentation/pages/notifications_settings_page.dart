import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/denta_refresh.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/presentation/manager/notification_settings_bloc.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/presentation/widgets/notification_settings_tile.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';

/// The notification-settings screen.
///
/// Built **entirely** from `GET /notification-settings`: every label,
/// description and the ordering come from the response, so categories can be
/// added, renamed or reworded server-side without an app update. Nothing is
/// hardcoded here except the icons, which are a purely visual mapping with a
/// neutral fallback for keys this build has never seen.
///
/// Categories that cannot be switched off never appear in the response, so
/// there is no disabled row to render for them.
class NotificationsSettingsPage extends StatelessWidget {
  const NotificationsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<NotificationSettingsBloc>()
            ..add(const NotificationSettingsEvent.load()),
      child: const _NotificationsSettingsContent(),
    );
  }
}

class _NotificationsSettingsContent extends StatelessWidget {
  const _NotificationsSettingsContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return AdaptivePageScaffold(
      title: l10n.notificationsSettings,
      body: DentaRefresh(
        onRefresh: () => _refresh(context),
        child:
            BlocConsumer<NotificationSettingsBloc, NotificationSettingsState>(
              // A rejected toggle has already rolled the switch back; the
              // snackbar is the only thing that tells the user why.
              listenWhen: (prev, curr) =>
                  curr.errorMessage != null &&
                  curr.errorMessage != prev.errorMessage &&
                  curr.status == NotificationSettingsStatus.success,
              listener: (context, state) {
                AppSnackbar.showError(context, title: state.errorMessage!);
              },
              builder: (context, state) {
                switch (state.status) {
                  case NotificationSettingsStatus.initial:
                  case NotificationSettingsStatus.loading:
                    return const _SettingsSkeleton();

                  case NotificationSettingsStatus.failure:
                    return SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        dentaGutter,
                        14.h,
                        dentaGutter,
                        28.h,
                      ),
                      child: StateCard(
                        icon: Icons.cloud_off_rounded,
                        tone: ColorManager.error,
                        title: l10n.notificationSettingsLoadFailed,
                        message: state.errorMessage ?? l10n.somethingWentWrong,
                        actionLabel: l10n.retry,
                        onAction: () => context
                            .read<NotificationSettingsBloc>()
                            .add(const NotificationSettingsEvent.load()),
                      ),
                    );

                  case NotificationSettingsStatus.success:
                    if (state.settings.isEmpty) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          dentaGutter,
                          14.h,
                          dentaGutter,
                          28.h,
                        ),
                        child: StateCard(
                          icon: Icons.notifications_off_outlined,
                          title: l10n.noNotificationSettings,
                          message: l10n.noNotificationSettingsHint,
                        ),
                      );
                    }
                    return _buildList(context, state);
                }
              },
            ),
      ),
      onBack: () => context.canPop() ? context.pop() : context.go('/'),
      backgroundColor: c.scaffoldBg,
    );
  }

  /// Safe to pull at any time: each switch writes through on the spot, so
  /// there is never an unsaved edit for a refetch to throw away.
  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<NotificationSettingsBloc>();
    bloc.add(const NotificationSettingsEvent.load());
    await bloc.stream.settled(
      (state) => state.status != NotificationSettingsStatus.loading,
    );
  }

  Widget _buildList(BuildContext context, NotificationSettingsState state) {
    final l10n = AppLocalizations.of(context)!;
    final settings = state.settings;
    // The one number the user came for: how much of this list is actually
    // reaching them. It sits beside the heading rather than in a hero tile -
    // on a screen this short the list is never more than a thumb away.
    final on = settings.where((s) => s.enabled).length;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(dentaGutter, 14.h, dentaGutter, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(
            l10n.notificationCategories,
            trailing: CountPill.label(
              l10n.categoriesOnCount(on, settings.length),
            ),
          ),
          SizedBox(height: 10.h),
          for (var i = 0; i < settings.length; i++) ...[
            if (i > 0) SizedBox(height: 8.h),
            NotificationSettingsTile(
              icon: _iconForKey(settings[i].key),
              iconColor: _colorForKey(settings[i].key),
              title: settings[i].name,
              subtitle: settings[i].description,
              value: settings[i].enabled,
              isPending: state.isPending(settings[i].key),
              onChanged: (enabled) =>
                  context.read<NotificationSettingsBloc>().add(
                    NotificationSettingsEvent.toggle(
                      key: settings[i].key,
                      enabled: enabled,
                    ),
                  ),
            ),
          ],
        ],
      ),
    );
  }

  /// Visual mapping only — an unrecognised key still renders, with a neutral
  /// bell. New categories ship server-side and must not break this screen.
  IconData _iconForKey(String key) {
    switch (key) {
      case NotificationCategories.appointmentReminder:
        return Icons.calendar_month_outlined;
      case NotificationCategories.paymentReminder:
        return Icons.receipt_long_outlined;
      case NotificationCategories.announcement:
        return Icons.campaign_outlined;
      case NotificationCategories.clinicInvitation:
        return Icons.group_add_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _colorForKey(String key) {
    switch (key) {
      case NotificationCategories.appointmentReminder:
        return ColorManager.info;
      case NotificationCategories.paymentReminder:
        return ColorManager.warning;
      case NotificationCategories.announcement:
        return ColorManager.purple;
      case NotificationCategories.clinicInvitation:
        return ColorManager.success;
      default:
        return ColorManager.primary;
    }
  }
}

/// Holds the real layout's slots while the categories load - heading, then
/// stacked cards at the same 8px pitch - so nothing jumps when they arrive.
class _SettingsSkeleton extends StatelessWidget {
  const _SettingsSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(dentaGutter, 14.h, dentaGutter, 28.h),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(width: 96.w, height: 13.h),
            SizedBox(height: 10.h),
            for (var i = 0; i < 4; i++) ...[
              if (i > 0) SizedBox(height: 8.h),
              AppCard(
                padding: EdgeInsetsDirectional.fromSTEB(13.w, 11.h, 10.w, 11.h),
                child: Row(
                  children: [
                    ShimmerBox(
                      width: 32.w,
                      height: 32.w,
                      radius: BorderRadius.circular(11.r),
                    ),
                    SizedBox(width: 11.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerBox(width: 120.w, height: 12.h),
                          SizedBox(height: 6.h),
                          ShimmerBox(width: 170.w, height: 10.h),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    ShimmerBox(
                      width: 38.w,
                      height: 22.h,
                      radius: BorderRadius.circular(11.r),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
