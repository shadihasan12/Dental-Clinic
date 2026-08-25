import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Which slice of the loaded inbox is on screen.
///
/// A filter, not a tab: both settings render the same list of the same kind of
/// thing, so it is a switchable chip pair rather than a TabBar.
enum NotificationFilter { all, unread }

/// Back + title. The screen's identity row; the filter rail below it is what
/// stays pinned while the list scrolls.
class NotificationsTopBar extends StatelessWidget {
  const NotificationsTopBar({
    super.key,
    required this.title,
    required this.onBack,
  });

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      color: c.surfaceBg,
      padding: EdgeInsetsDirectional.fromSTEB(4.w, 4.h, 14.w, 6.h),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 18.w,
              color: c.textPrimary,
            ),
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pinned filter rail.
///
/// Stays put while the list scrolls so switching between everything and the
/// unread remainder never costs a scroll back to the top.
class NotificationInboxHeader extends SliverPersistentHeaderDelegate {
  NotificationInboxHeader({
    required this.allChipLabel,
    required this.unreadChipLabel,
    required this.filter,
    required this.onFilterChanged,
  });

  final String allChipLabel;
  final String unreadChipLabel;
  final NotificationFilter filter;
  final ValueChanged<NotificationFilter> onFilterChanged;

  /// Slack on purpose: the chips sit centred in this slot so a raised OS text
  /// scale eats the spare height instead of overflowing a pinned header.
  double get _height => 50.h;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  bool shouldRebuild(covariant NotificationInboxHeader old) =>
      old.allChipLabel != allChipLabel ||
      old.unreadChipLabel != unreadChipLabel ||
      old.filter != filter;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) {
    final c = ColorManager.of(context);

    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: c.surfaceBg,
        border: Border(bottom: BorderSide(color: c.borderLight)),
      ),
      alignment: AlignmentDirectional.centerStart,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        children: [
          _FilterChip(
            label: allChipLabel,
            active: filter == NotificationFilter.all,
            onTap: () => onFilterChanged(NotificationFilter.all),
          ),
          SizedBox(width: 6.w),
          _FilterChip(
            label: unreadChipLabel,
            active: filter == NotificationFilter.unread,
            onTap: () => onFilterChanged(NotificationFilter.unread),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Center(
      child: Material(
        color: active ? ColorManager.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: active ? null : Border.all(color: c.borderLight),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                fontFamily: FontHelper.fontFamily(context),
                color: active ? ColorManager.white : c.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
