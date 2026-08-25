import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// One item in [GlassTabBar].
///
/// On iOS, [systemIcon] is an SF Symbol name passed straight to
/// `UIImage(systemName:)` so the bar renders icons exactly the way UIKit's
/// own tab bars do. [selectedSystemIcon] is optional — pass it to swap to a
/// filled variant when active (e.g. `house` -> `house.fill`).
class GlassTabItem {
  final String title;
  final String systemIcon;
  final String? selectedSystemIcon;

  const GlassTabItem({
    required this.title,
    required this.systemIcon,
    this.selectedSystemIcon,
  });

  Map<String, Object?> toMap() => {
        'title': title,
        'systemIcon': systemIcon,
        if (selectedSystemIcon != null) 'systemIconSelected': selectedSystemIcon,
      };
}

/// A tab bar that hosts a real iOS `UITabBar` via a platform view, so we get
/// the system blur/material, the active indicator, and (on iOS 26) the
/// liquid-glass drag-to-slide interaction for free.
///
/// On non-iOS platforms it falls back to a Material `NavigationBar`.
class GlassTabBar extends StatefulWidget {
  const GlassTabBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    this.tintColor,
    this.barHeight = 49,
  });

  final List<GlassTabItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  /// Tint color applied to the active item. `null` lets the system pick
  /// (iOS default blue).
  final Color? tintColor;

  /// Visible bar height above the safe area inset. 49pt matches the iOS
  /// default tab-bar height.
  final double barHeight;

  @override
  State<GlassTabBar> createState() => _GlassTabBarState();
}

class _GlassTabBarState extends State<GlassTabBar> {
  MethodChannel? _channel;

  Map<String, Object?> _paramsFor(BuildContext context) {
    final tint = widget.tintColor;
    final direction = Directionality.of(context);
    return {
      'items': widget.items.map((e) => e.toMap()).toList(),
      'selectedIndex': widget.selectedIndex,
      'textDirection': direction == TextDirection.rtl ? 'rtl' : 'ltr',
      if (tint != null) 'tintColor': _hex(tint),
    };
  }

  String _hex(Color color) =>
      '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';

  void _onPlatformViewCreated(int id) {
    final channel = MethodChannel('glass_tab_bar_$id');
    channel.setMethodCallHandler((call) async {
      if (call.method == 'onTap' && call.arguments is int) {
        widget.onTap(call.arguments as int);
      }
      return null;
    });
    _channel = channel;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Locale (and thus Directionality + l10n strings) can change without the
    // widget itself changing, so re-push the items here too.
    _channel?.invokeMethod('setItems', _paramsFor(context));
  }

  @override
  void didUpdateWidget(covariant GlassTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _channel?.invokeMethod('setSelectedIndex', widget.selectedIndex);
    }
    if (!_itemsEqual(oldWidget.items, widget.items) ||
        oldWidget.tintColor != widget.tintColor) {
      _channel?.invokeMethod('setItems', _paramsFor(context));
    }
  }

  static bool _itemsEqual(List<GlassTabItem> a, List<GlassTabItem> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].title != b[i].title ||
          a[i].systemIcon != b[i].systemIcon ||
          a[i].selectedSystemIcon != b[i].selectedSystemIcon) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = systemBottomInset(context);
    final totalHeight = widget.barHeight + bottomInset;

    if (defaultTargetPlatform != TargetPlatform.iOS) {
      return _MaterialFallback(
        items: widget.items,
        selectedIndex: widget.selectedIndex,
        onTap: widget.onTap,
        tintColor: widget.tintColor,
      );
    }

    return SizedBox(
      height: totalHeight,
      child: UiKitView(
        viewType: 'glass_tab_bar',
        creationParams: _paramsFor(context),
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      ),
    );
  }
}

class _MaterialFallback extends StatelessWidget {
  const _MaterialFallback({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    required this.tintColor,
  });

  final List<GlassTabItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Color? tintColor;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final activeColor = tintColor ?? ColorManager.primary;
    final inactiveColor = c.textTertiary;
    final fontFamily = FontHelper.fontFamily(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(
          top: BorderSide(color: c.borderLight, width: 0.5),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: c.cardBg,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          indicatorColor: activeColor.withValues(alpha: 0.12),
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontFamily: fontFamily,
              fontSize: 11,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              color: selected ? activeColor : inactiveColor,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              size: 22,
              color: selected ? activeColor : inactiveColor,
            );
          }),
        ),
        child: NavigationBar(
          height: 68,
          selectedIndex: selectedIndex,
          onDestinationSelected: onTap,
          destinations: items
              .map(
                (item) => NavigationDestination(
                  icon: Icon(_iconForSymbol(item.systemIcon)),
                  selectedIcon: Icon(
                    _iconForSymbol(
                      item.selectedSystemIcon ?? item.systemIcon,
                    ),
                  ),
                  label: item.title,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // Light-weight SF Symbol → Material icon map for the fallback. Only the
  // symbols actually used by this app need to be covered.
  static IconData _iconForSymbol(String symbol) {
    switch (symbol) {
      case 'house':
        return Icons.home_outlined;
      case 'house.fill':
        return Icons.home;
      case 'person.2':
        return Icons.people_outline;
      case 'person.2.fill':
        return Icons.people;
      case 'calendar':
        return Icons.calendar_today_outlined;
      case 'calendar.badge.clock':
        return Icons.event;
      case 'dollarsign.circle':
        return Icons.attach_money_outlined;
      case 'dollarsign.circle.fill':
        return Icons.attach_money;
      case 'line.3.horizontal':
        return Icons.menu;
      case 'ellipsis':
        return Icons.more_horiz;
      default:
        return Icons.circle_outlined;
    }
  }
}
