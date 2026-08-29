import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_routing.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/presentation/manager/notification_bloc.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/notification_card.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/notification_inbox_header.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/notification_list_states.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/custom_widgets/denta_refresh.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
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

  /// Applied over the pages already loaded, not sent to the server - the
  /// inbox has no unread-only endpoint, and re-querying on a cursor-paged
  /// list would fight the paging.
  NotificationFilter _filter = NotificationFilter.all;

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

  /// The refresh event deliberately emits no loading state, so the next state
  /// of any kind is the one that says the page landed.
  Future<void> _refresh() async {
    final bloc = context.read<NotificationBloc>();
    bloc.add(const NotificationEvent.refresh());
    await bloc.stream.settled((_) => true);
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
    final c = ColorManager.of(context);

    final isDesktop = Responsive.isDesktop(context);

    return DesktopShell(
      title: l10n.notifications,
      body: Scaffold(
        backgroundColor: c.scaffoldBg,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // DesktopShell's top bar already carries the title and a back
              // affordance, so the mobile bar would be a second one.
              if (!isDesktop)
                NotificationsTopBar(
                  title: l10n.notifications,
                  // Reachable directly from a push tap, so the stack may be
                  // empty - fall back to the root instead of throwing.
                  onBack: () =>
                      context.canPop() ? context.pop() : context.go('/'),
                ),
              Expanded(
                child: BlocBuilder<NotificationBloc, NotificationState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case NotificationStatus.initial:
                      case NotificationStatus.loading:
                        return const NotificationListSkeleton();

                      case NotificationStatus.failure:
                        return DentaRefresh(
                          onRefresh: _refresh,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(
                              14.w,
                              16.h,
                              14.w,
                              24.h,
                            ),
                            child: NotificationErrorState(
                              message:
                                  state.errorMessage ?? l10n.somethingWentWrong,
                              onRetry: () => context
                                  .read<NotificationBloc>()
                                  .add(const NotificationEvent.load()),
                            ),
                          ),
                        );

                      case NotificationStatus.success:
                        return _buildInbox(context, state, l10n);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInbox(
    BuildContext context,
    NotificationState state,
    AppLocalizations l10n,
  ) {
    final visible = _filter == NotificationFilter.unread
        ? state.notifications.where((n) => !n.isRead).toList()
        : state.notifications;
    final rows = _buildRows(visible, l10n);

    // The docked bar floats over the list, so the tail has to clear it.
    final barHeight = state.hasUnread
        ? NotificationActionBar.height(context)
        : MediaQuery.viewPaddingOf(context).bottom;

    // An inbox stretched across a 1080p window leaves each card mostly empty
    // space; the reading column is capped and centred instead.
    return AdaptiveContentWidth(
      child: Stack(
        children: [
          DentaRefresh(
            onRefresh: _refresh,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: NotificationInboxHeader(
                    allChipLabel: l10n.allFilter,
                    unreadChipLabel: l10n.unread,
                    filter: _filter,
                    onFilterChanged: (f) => setState(() => _filter = f),
                  ),
                ),
                if (rows.isEmpty)
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(14.w, 24.h, 14.w, 24.h),
                    sliver: SliverToBoxAdapter(
                      child: _filter == NotificationFilter.unread
                          ? NotificationEmptyState(
                              title: l10n.noUnreadNotifications,
                              message: l10n.noUnreadNotificationsDesc,
                            )
                          : NotificationEmptyState(
                              title: l10n.noNotifications,
                              message: l10n.noNotificationsDesc,
                            ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 0),
                    sliver: SliverList.builder(
                      itemCount: rows.length,
                      itemBuilder: (context, index) {
                        final row = rows[index];
                        if (row is _SectionRow) {
                          return _SectionHeader(
                            title: row.title,
                            // No leading gap above the first label; the pinned
                            // header already provides the break.
                            topGap: index == 0 ? 8.h : 18.h,
                          );
                        }

                        final notification =
                            (row as _NotificationRow).notification;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: NotificationCard(
                            notification: notification,
                            onTap: () => _onNotificationTap(notification),
                            onLongPress: () =>
                                _onNotificationLongPress(notification),
                            timeAgo: _formatTimeAgo(l10n, notification.sentAt),
                          ),
                        );
                      },
                    ),
                  ),
                if (state.isLoadingMore)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                  ),
                SliverToBoxAdapter(child: SizedBox(height: barHeight + 12.h)),
              ],
            ),
          ),
          if (state.hasUnread)
            PositionedDirectional(
              start: 0,
              end: 0,
              bottom: 0,
              child: NotificationActionBar(
                label: l10n.markAllAsRead,
                onPressed: () => context.read<NotificationBloc>().add(
                  const NotificationEvent.markAllAsRead(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Flattens the (already newest-first) inbox into section labels + cards.
  ///
  /// Grouping is purely local and relative to *today*, so it stays correct
  /// without asking the server for buckets. Empty buckets emit no label.
  List<_Row> _buildRows(
    List<NotificationEntity> notifications,
    AppLocalizations l10n,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final rows = <_Row>[];
    _DateBucket? currentBucket;

    for (final notification in notifications) {
      final sentAt = notification.sentAt.toLocal();
      final day = DateTime(sentAt.year, sentAt.month, sentAt.day);
      final daysAgo = today.difference(day).inDays;

      // Anything stamped in the future (clock skew) still belongs under Today.
      final bucket = daysAgo <= 0
          ? _DateBucket.today
          : daysAgo == 1
          ? _DateBucket.yesterday
          : daysAgo <= 7
          ? _DateBucket.pastWeek
          : _DateBucket.older;

      if (bucket != currentBucket) {
        currentBucket = bucket;
        rows.add(_SectionRow(_bucketTitle(l10n, bucket)));
      }
      rows.add(_NotificationRow(notification));
    }

    return rows;
  }

  String _bucketTitle(AppLocalizations l10n, _DateBucket bucket) {
    switch (bucket) {
      case _DateBucket.today:
        return l10n.today;
      case _DateBucket.yesterday:
        return l10n.yesterday;
      case _DateBucket.pastWeek:
        return l10n.pastWeek;
      case _DateBucket.older:
        return l10n.older;
    }
  }

  String _formatTimeAgo(AppLocalizations l10n, DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);

    if (diff.inMinutes < 1) return l10n.justNow;
    if (diff.inMinutes < 60) return l10n.minutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10n.hoursAgo(diff.inHours);
    return l10n.daysAgo(diff.inDays);
  }
}

enum _DateBucket { today, yesterday, pastWeek, older }

sealed class _Row {
  const _Row();
}

class _SectionRow extends _Row {
  const _SectionRow(this.title);
  final String title;
}

class _NotificationRow extends _Row {
  const _NotificationRow(this.notification);
  final NotificationEntity notification;
}

/// Uppercase micro-label - it separates the run of cards without competing
/// with their titles.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.topGap});

  final String title;
  final double topGap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(2.w, topGap, 2.w, 8.h),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 9.5.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
          fontFamily: FontHelper.fontFamily(context),
          color: c.textTertiary,
        ),
      ),
    );
  }
}
