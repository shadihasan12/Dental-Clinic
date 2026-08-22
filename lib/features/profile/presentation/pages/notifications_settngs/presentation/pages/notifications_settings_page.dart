import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_card.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/presentation/manager/notification_settings_bloc.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/presentation/widgets/notification_settings_tile.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
      create: (_) => getIt<NotificationSettingsBloc>()
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

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: Column(
        children: [
          PageHeader(
            title: l10n.notificationsSettings,
            onBack: () => context.canPop() ? context.pop() : context.go('/'),
          ),
          Expanded(
            child: BlocConsumer<NotificationSettingsBloc,
                NotificationSettingsState>(
              // A rejected toggle has already rolled the switch back; the
              // snackbar is the only thing that tells the user why.
              listenWhen: (prev, curr) =>
                  curr.errorMessage != null &&
                  curr.errorMessage != prev.errorMessage &&
                  curr.status == NotificationSettingsStatus.success,
              listener: (context, state) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(state.errorMessage!)),
                  );
              },
              builder: (context, state) {
                switch (state.status) {
                  case NotificationSettingsStatus.initial:
                  case NotificationSettingsStatus.loading:
                    return const Center(child: CircularProgressIndicator());

                  case NotificationSettingsStatus.failure:
                    return _ErrorState(
                      message: state.errorMessage ?? l10n.somethingWentWrong,
                      onRetry: () => context
                          .read<NotificationSettingsBloc>()
                          .add(const NotificationSettingsEvent.load()),
                    );

                  case NotificationSettingsStatus.success:
                    if (state.settings.isEmpty) {
                      return _EmptyState(l10n: l10n);
                    }
                    return _buildList(context, state);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, NotificationSettingsState state) {
    final settings = state.settings;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: CustomCard(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            for (var i = 0; i < settings.length; i++)
              NotificationSettingsTile(
                icon: _iconForKey(settings[i].key),
                iconColor: _colorForKey(settings[i].key),
                title: settings[i].name,
                subtitle: settings[i].description,
                value: settings[i].enabled,
                isPending: state.isPending(settings[i].key),
                showDivider: i != settings.length - 1,
                onChanged: (enabled) =>
                    context.read<NotificationSettingsBloc>().add(
                          NotificationSettingsEvent.toggle(
                            key: settings[i].key,
                            enabled: enabled,
                          ),
                        ),
              ),
          ],
        ),
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

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Text(
          l10n.noNotificationSettings,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: c.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, size: 40.w, color: c.textSubtle),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: onRetry,
              child: Text(
                l10n.retry,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
