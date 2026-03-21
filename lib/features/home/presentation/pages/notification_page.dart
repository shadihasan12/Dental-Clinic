import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/home/presentation/manager/notification_bloc.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/notification_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationBloc>()
        ..add(const NotificationEvent.loadNotifications()),
      child: const _NotificationContent(),
    );
  }
}

class _NotificationContent extends StatelessWidget {
  const _NotificationContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: Column(
        children: [
          // Header is always visible
          BlocBuilder<NotificationBloc, NotificationState>(
            buildWhen: (prev, curr) => prev != curr,
            builder: (context, state) {
              final hasUnread = state.maybeWhen(
                loaded: (notifications) => notifications.any((n) => !n.isRead),
                orElse: () => false,
              );
              return PageHeader(
                title: l10n.notifications,
                onBack: () => context.pop(),
                actions: [
                  if (hasUnread)
                    GestureDetector(
                      onTap: () => context
                          .read<NotificationBloc>()
                          .add(const NotificationEvent.markAllAsRead()),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          l10n.markAllAsRead,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w500,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          // Body
          Expanded(
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (message) => Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorManager.of(context).textSecondary,
                        ),
                      ),
                    ),
                  ),
                  loaded: (notifications) {
                    if (notifications.isEmpty) {
                      return _buildEmptyState(context, l10n);
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      itemCount: notifications.length,
                      separatorBuilder: (_, __) =>
                          Divider(height: 1, color: ColorManager.of(context).divider),
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return NotificationCard(
                          notification: notification,
                          onTap: () => context
                              .read<NotificationBloc>()
                              .add(NotificationEvent.markAsRead(
                                  notification.id)),
                          timeAgo: _formatTimeAgo(
                              context, notification.timestamp),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: ColorManager.primary10,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 40.w,
                color: ColorManager.primary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              l10n.noNotifications,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.noNotificationsDesc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(BuildContext context, DateTime timestamp) {
    final l10n = AppLocalizations.of(context)!;
    final diff = DateTime.now().difference(timestamp);

    if (diff.inMinutes < 1) return l10n.justNow;
    if (diff.inMinutes < 60) return l10n.minutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10n.hoursAgo(diff.inHours);
    return l10n.daysAgo(diff.inDays);
  }
}
