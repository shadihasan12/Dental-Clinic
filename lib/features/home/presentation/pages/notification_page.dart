import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
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
    if (Responsive.isDesktop(context)) {
      return const _NotificationDesktop();
    }
    return const _NotificationMobile();
  }
}

// ═══════════════════════════════════════════════════════════════════════
// MOBILE (unchanged behavior)
// ═══════════════════════════════════════════════════════════════════════

class _NotificationMobile extends StatelessWidget {
  const _NotificationMobile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: Column(
        children: [
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
                      return _buildMobileEmpty(context, l10n);
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      itemCount: notifications.length,
                      separatorBuilder: (_, _) => Divider(
                        height: 1,
                        color: ColorManager.of(context).divider,
                      ),
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return NotificationCard(
                          notification: notification,
                          onTap: () => context
                              .read<NotificationBloc>()
                              .add(NotificationEvent.markAsRead(
                                  notification.id)),
                          timeAgo:
                              _formatTimeAgo(context, notification.timestamp),
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

  Widget _buildMobileEmpty(BuildContext context, AppLocalizations l10n) {
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

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP
// ═══════════════════════════════════════════════════════════════════════

enum _NotifFilter { all, unread }

class _NotificationDesktop extends StatefulWidget {
  const _NotificationDesktop();

  @override
  State<_NotificationDesktop> createState() => _NotificationDesktopState();
}

class _NotificationDesktopState extends State<_NotificationDesktop> {
  _NotifFilter _filter = _NotifFilter.all;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          const contentMax = 920.0;
          final outerPadding = width > contentMax + 64
              ? (width - contentMax) / 2
              : 32.0;

          return Column(
            children: [
              _DesktopTopBar(
                fontFamily: fontFamily,
                onBack: () => context.pop(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    outerPadding,
                    32,
                    outerPadding,
                    40,
                  ),
                  child: BlocBuilder<NotificationBloc, NotificationState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 120),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (message) => _DesktopErrorState(
                          message: message,
                          fontFamily: fontFamily,
                          onRetry: () => context.read<NotificationBloc>().add(
                              const NotificationEvent.loadNotifications()),
                        ),
                        loaded: (notifications) {
                          final unreadCount =
                              notifications.where((n) => !n.isRead).length;
                          final filtered = _filter == _NotifFilter.unread
                              ? notifications
                                  .where((n) => !n.isRead)
                                  .toList()
                              : notifications;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _DesktopHeader(
                                fontFamily: fontFamily,
                                totalCount: notifications.length,
                                unreadCount: unreadCount,
                                markAllLabel: l10n.markAllAsRead,
                                onMarkAll: unreadCount == 0
                                    ? null
                                    : () => context
                                        .read<NotificationBloc>()
                                        .add(const NotificationEvent
                                            .markAllAsRead()),
                              ),
                              const SizedBox(height: 24),
                              _DesktopFilterBar(
                                fontFamily: fontFamily,
                                filter: _filter,
                                allCount: notifications.length,
                                unreadCount: unreadCount,
                                onChange: (f) => setState(() => _filter = f),
                              ),
                              const SizedBox(height: 20),
                              if (filtered.isEmpty)
                                _DesktopEmptyState(
                                  fontFamily: fontFamily,
                                  title: _filter == _NotifFilter.unread
                                      ? 'No unread notifications'
                                      : l10n.noNotifications,
                                  subtitle: _filter == _NotifFilter.unread
                                      ? 'You\'re all caught up.'
                                      : l10n.noNotificationsDesc,
                                )
                              else
                                ..._buildGroupedSections(
                                  context,
                                  filtered,
                                  fontFamily,
                                ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildGroupedSections(
    BuildContext context,
    List<NotificationEntity> items,
    String fontFamily,
  ) {
    final now = DateTime.now();
    final today = <NotificationEntity>[];
    final yesterday = <NotificationEntity>[];
    final earlier = <NotificationEntity>[];

    bool sameDay(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

    final y = now.subtract(const Duration(days: 1));

    for (final n in items) {
      if (sameDay(n.timestamp, now)) {
        today.add(n);
      } else if (sameDay(n.timestamp, y)) {
        yesterday.add(n);
      } else {
        earlier.add(n);
      }
    }

    final sections = <Widget>[];
    void addSection(String title, List<NotificationEntity> group) {
      if (group.isEmpty) return;
      if (sections.isNotEmpty) sections.add(const SizedBox(height: 28));
      sections.add(_DesktopSectionHeader(title: title, fontFamily: fontFamily));
      sections.add(const SizedBox(height: 12));
      sections.add(
        _DesktopNotificationList(
          items: group,
          fontFamily: fontFamily,
          onTap: (n) => context
              .read<NotificationBloc>()
              .add(NotificationEvent.markAsRead(n.id)),
        ),
      );
    }

    addSection('Today', today);
    addSection('Yesterday', yesterday);
    addSection('Earlier', earlier);
    return sections;
  }
}

// ── Desktop top bar ────────────────────────────────────────────────────

class _DesktopTopBar extends StatelessWidget {
  const _DesktopTopBar({
    required this.fontFamily,
    required this.onBack,
  });

  final String fontFamily;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(bottom: BorderSide(color: c.borderLight)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _IconOnlyButton(
            icon: Icons.arrow_back_rounded,
            tooltip: 'Back',
            onTap: onBack,
          ),
          const SizedBox(width: 12),
          Text(
            l10n.notifications,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconOnlyButton extends StatefulWidget {
  const _IconOnlyButton({
    required this.icon,
    required this.onTap,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  State<_IconOnlyButton> createState() => _IconOnlyButtonState();
}

class _IconOnlyButtonState extends State<_IconOnlyButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final button = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: _hover ? c.cardBgSecondary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.borderLight),
          ),
          alignment: Alignment.center,
          child: Icon(widget.icon, size: 18, color: c.textPrimary),
        ),
      ),
    );
    if (widget.tooltip != null) {
      return Tooltip(message: widget.tooltip!, child: button);
    }
    return button;
  }
}

// ── Desktop header (title + counts + mark all) ─────────────────────────

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader({
    required this.fontFamily,
    required this.totalCount,
    required this.unreadCount,
    required this.markAllLabel,
    required this.onMarkAll,
  });

  final String fontFamily;
  final int totalCount;
  final int unreadCount;
  final String markAllLabel;
  final VoidCallback? onMarkAll;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '$unreadCount unread',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '$totalCount total',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
        _DesktopActionButton(
          label: markAllLabel,
          icon: Icons.done_all_rounded,
          fontFamily: fontFamily,
          enabled: onMarkAll != null,
          onTap: onMarkAll ?? () {},
        ),
      ],
    );
  }
}

class _DesktopActionButton extends StatefulWidget {
  const _DesktopActionButton({
    required this.label,
    required this.icon,
    required this.fontFamily,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String fontFamily;
  final bool enabled;
  final VoidCallback onTap;

  @override
  State<_DesktopActionButton> createState() => _DesktopActionButtonState();
}

class _DesktopActionButtonState extends State<_DesktopActionButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final color = widget.enabled
        ? ColorManager.primary
        : c.textTertiary;
    final bg = widget.enabled
        ? (_hover
            ? ColorManager.primary.withValues(alpha: 0.12)
            : ColorManager.primary.withValues(alpha: 0.08))
        : c.cardBgSecondary;

    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.enabled
                  ? ColorManager.primary.withValues(alpha: 0.2)
                  : c.borderLight,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 16, color: color),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: widget.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Filter bar ─────────────────────────────────────────────────────────

class _DesktopFilterBar extends StatelessWidget {
  const _DesktopFilterBar({
    required this.fontFamily,
    required this.filter,
    required this.allCount,
    required this.unreadCount,
    required this.onChange,
  });

  final String fontFamily;
  final _NotifFilter filter;
  final int allCount;
  final int unreadCount;
  final ValueChanged<_NotifFilter> onChange;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _FilterChip(
            label: 'All',
            count: allCount,
            selected: filter == _NotifFilter.all,
            fontFamily: fontFamily,
            onTap: () => onChange(_NotifFilter.all),
          ),
          const SizedBox(width: 4),
          _FilterChip(
            label: 'Unread',
            count: unreadCount,
            selected: filter == _NotifFilter.unread,
            fontFamily: fontFamily,
            onTap: () => onChange(_NotifFilter.unread),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatefulWidget {
  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.fontFamily,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final String fontFamily;
  final VoidCallback onTap;

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: widget.selected
                ? c.cardBg
                : (_hover ? c.cardBg.withValues(alpha: 0.5) : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            boxShadow: widget.selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: widget.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: widget.selected
                      ? c.textPrimary
                      : c.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: widget.selected
                      ? ColorManager.primary.withValues(alpha: 0.12)
                      : c.borderLight,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${widget.count}',
                  style: TextStyle(
                    fontFamily: widget.fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: widget.selected
                        ? ColorManager.primary
                        : c.textTertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section header ─────────────────────────────────────────────────────

class _DesktopSectionHeader extends StatelessWidget {
  const _DesktopSectionHeader({
    required this.title,
    required this.fontFamily,
  });

  final String title;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: c.textTertiary,
      ),
    );
  }
}

// ── Notification list card ─────────────────────────────────────────────

class _DesktopNotificationList extends StatelessWidget {
  const _DesktopNotificationList({
    required this.items,
    required this.fontFamily,
    required this.onTap,
  });

  final List<NotificationEntity> items;
  final String fontFamily;
  final ValueChanged<NotificationEntity> onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _DesktopNotificationRow(
              notification: items[i],
              fontFamily: fontFamily,
              onTap: () => onTap(items[i]),
              isFirst: i == 0,
              isLast: i == items.length - 1,
            ),
            if (i != items.length - 1)
              Divider(height: 1, color: c.borderLight),
          ],
        ],
      ),
    );
  }
}

class _DesktopNotificationRow extends StatefulWidget {
  const _DesktopNotificationRow({
    required this.notification,
    required this.fontFamily,
    required this.onTap,
    required this.isFirst,
    required this.isLast,
  });

  final NotificationEntity notification;
  final String fontFamily;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;

  @override
  State<_DesktopNotificationRow> createState() =>
      _DesktopNotificationRowState();
}

class _DesktopNotificationRowState extends State<_DesktopNotificationRow> {
  bool _hover = false;

  String _formatTimeAgo(BuildContext context, DateTime timestamp) {
    final l10n = AppLocalizations.of(context)!;
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) return l10n.justNow;
    if (diff.inMinutes < 60) return l10n.minutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10n.hoursAgo(diff.inHours);
    return l10n.daysAgo(diff.inDays);
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final n = widget.notification;
    final icon = _iconForType(n.type);
    final iconColor = _colorForType(n.type);

    final topRadius = widget.isFirst ? const Radius.circular(16) : Radius.zero;
    final bottomRadius =
        widget.isLast ? const Radius.circular(16) : Radius.zero;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          decoration: BoxDecoration(
            color: _hover
                ? ColorManager.primary.withValues(alpha: 0.04)
                : (n.isRead
                    ? Colors.transparent
                    : ColorManager.primary.withValues(alpha: 0.02)),
            borderRadius: BorderRadius.only(
              topLeft: topRadius,
              topRight: topRadius,
              bottomLeft: bottomRadius,
              bottomRight: bottomRadius,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unread dot column
              SizedBox(
                width: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: n.isRead
                      ? const SizedBox.shrink()
                      : Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: ColorManager.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Type icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 14),

              // Title / content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      n.title,
                      style: TextStyle(
                        fontFamily: widget.fontFamily,
                        fontSize: 14,
                        fontWeight:
                            n.isRead ? FontWeight.w500 : FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      n.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: widget.fontFamily,
                        fontSize: 13,
                        color: c.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),

              // Timestamp
              Text(
                _formatTimeAgo(context, n.timestamp),
                style: TextStyle(
                  fontFamily: widget.fontFamily,
                  fontSize: 12,
                  color: c.textTertiary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForType(NotificationType type) {
    switch (type) {
      case NotificationType.appointment:
        return Icons.calendar_today_rounded;
      case NotificationType.payment:
        return Icons.payments_rounded;
      case NotificationType.patient:
        return Icons.person_add_rounded;
      case NotificationType.report:
        return Icons.bar_chart_rounded;
      case NotificationType.treatment:
        return Icons.medical_services_rounded;
      case NotificationType.cancellation:
        return Icons.cancel_rounded;
    }
  }

  Color _colorForType(NotificationType type) {
    switch (type) {
      case NotificationType.appointment:
        return ColorManager.info;
      case NotificationType.payment:
        return ColorManager.primary;
      case NotificationType.patient:
        return ColorManager.success;
      case NotificationType.report:
        return ColorManager.purple;
      case NotificationType.treatment:
        return ColorManager.warning;
      case NotificationType.cancellation:
        return ColorManager.error;
    }
  }
}

// ── Empty state ────────────────────────────────────────────────────────

class _DesktopEmptyState extends StatelessWidget {
  const _DesktopEmptyState({
    required this.fontFamily,
    required this.title,
    required this.subtitle,
  });

  final String fontFamily;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 56),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.notifications_none_rounded,
              size: 38,
              color: ColorManager.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13,
              color: c.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Error state ────────────────────────────────────────────────────────

class _DesktopErrorState extends StatelessWidget {
  const _DesktopErrorState({
    required this.message,
    required this.fontFamily,
    required this.onRetry,
  });

  final String message;
  final String fontFamily;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: ColorManager.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.error_outline_rounded,
              size: 36,
              color: ColorManager.error,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13,
              color: c.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          _DesktopActionButton(
            label: 'Retry',
            icon: Icons.refresh_rounded,
            fontFamily: fontFamily,
            enabled: true,
            onTap: onRetry,
          ),
        ],
      ),
    );
  }
}
