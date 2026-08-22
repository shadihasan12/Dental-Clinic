import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_routing.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
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
      create: (_) =>
          getIt<NotificationBloc>()..add(const NotificationEvent.load()),
      child: const _NotificationContent(),
    );
  }
}

class _NotificationContent extends StatefulWidget {
  const _NotificationContent();

  @override
  State<_NotificationContent> createState() => _NotificationContentState();
}

class _NotificationContentState extends State<_NotificationContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    // Start the next page while the user is still ~2 rows from the bottom, so
    // the list rarely stalls under the thumb. The bloc ignores the event when
    // there is no cursor or a page is already in flight.
    if (position.pixels >= position.maxScrollExtent - 300) {
      context.read<NotificationBloc>().add(const NotificationEvent.loadMore());
    }
  }

  void _onNotificationTap(NotificationEntity notification) {
    final bloc = context.read<NotificationBloc>();
    if (!notification.isRead) {
      bloc.add(NotificationEvent.markAsRead(notification.id));
    }
    // Announcements (and anything this build doesn't recognise) route back to
    // this same screen; don't push a second copy of it.
    if (NotificationRouting.locationFor(notification.data) ==
        NotificationRouting.notificationsPath) {
      return;
    }
    NotificationRouting.navigate(GoRouter.of(context), notification.data);
  }

  void _onNotificationLongPress(NotificationEntity notification) {
    final bloc = context.read<NotificationBloc>();
    bloc.add(
      notification.isRead
          ? NotificationEvent.markAsUnread(notification.id)
          : NotificationEvent.markAsRead(notification.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: Column(
        children: [
          // Header is always visible
          BlocBuilder<NotificationBloc, NotificationState>(
            buildWhen: (prev, curr) => prev.hasUnread != curr.hasUnread,
            builder: (context, state) {
              return PageHeader(
                title: l10n.notifications,
                // Reachable directly from a push tap, so the stack may be
                // empty - fall back to the root instead of throwing.
                onBack: () =>
                    context.canPop() ? context.pop() : context.go('/'),
                actions: [
                  if (state.hasUnread)
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
                switch (state.status) {
                  case NotificationStatus.initial:
                  case NotificationStatus.loading:
                    return const _NotificationListSkeleton();

                  case NotificationStatus.failure:
                    return _ErrorState(
                      message: state.errorMessage ?? l10n.somethingWentWrong,
                      onRetry: () => context
                          .read<NotificationBloc>()
                          .add(const NotificationEvent.load()),
                    );

                  case NotificationStatus.success:
                    return RefreshIndicator(
                      color: ColorManager.primary,
                      onRefresh: () async {
                        context
                            .read<NotificationBloc>()
                            .add(const NotificationEvent.refresh());
                        // Give the request a beat before retracting the
                        // spinner; the bloc emits again when it lands.
                        await Future<void>.delayed(
                          const Duration(milliseconds: 400),
                        );
                      },
                      child: state.notifications.isEmpty
                          ? _EmptyState(l10n: l10n)
                          : _buildList(context, state, l10n),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    NotificationState state,
    AppLocalizations l10n,
  ) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final c = ColorManager.of(context);

    return ListView.separated(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(0, 8.h, 0, 8.h + bottomInset),
      // One extra row for the paging spinner when another page is on its way.
      itemCount: state.notifications.length + (state.isLoadingMore ? 1 : 0),
      separatorBuilder: (_, __) => Divider(height: 1, color: c.divider),
      itemBuilder: (context, index) {
        if (index >= state.notifications.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        final notification = state.notifications[index];
        return NotificationCard(
          notification: notification,
          onTap: () => _onNotificationTap(notification),
          onLongPress: () => _onNotificationLongPress(notification),
          timeAgo: _formatTimeAgo(l10n, notification.sentAt),
        );
      },
    );
  }

  String _formatTimeAgo(AppLocalizations l10n, DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);

    if (diff.inMinutes < 1) return l10n.justNow;
    if (diff.inMinutes < 60) return l10n.minutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10n.hoursAgo(diff.inHours);
    return l10n.daysAgo(diff.inDays);
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    // Scrollable so pull-to-refresh still works on an empty inbox.
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: Column(
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
                    color: c.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  l10n.noNotificationsDesc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: c.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
            Icon(
              Icons.cloud_off_rounded,
              size: 40.w,
              color: c.textSubtle,
            ),
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

class _NotificationListSkeleton extends StatelessWidget {
  const _NotificationListSkeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(0, 8.h, 0, 8.h + bottomInset),
      itemCount: 6,
      separatorBuilder: (_, __) => Divider(height: 1, color: c.divider),
      itemBuilder: (_, __) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(
              width: 40.w,
              height: 40.w,
              radius: BorderRadius.circular(10.r),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 180.w, height: 14.h),
                  SizedBox(height: 8.h),
                  ShimmerBox(width: double.infinity, height: 12.h),
                  SizedBox(height: 6.h),
                  ShimmerBox(width: 220.w, height: 12.h),
                  SizedBox(height: 8.h),
                  ShimmerBox(width: 60.w, height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
