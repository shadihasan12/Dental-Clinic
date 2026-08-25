import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PermissionGate extends StatelessWidget {
  /// Single slug shorthand. Use when only one permission grants access.
  final String? feature;

  /// Any-of list. Use when multiple slugs grant access (e.g. a `view-`
  /// slug *or* its `manage-` counterpart — admins with manage but no
  /// explicit view would otherwise see a false "access denied" page).
  final List<String>? anyOf;

  final Widget child;

  const PermissionGate({
    super.key,
    this.feature,
    this.anyOf,
    required this.child,
  }) : assert(
          feature != null || anyOf != null,
          'PermissionGate needs either `feature` or `anyOf`.',
        );

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<ClinicPermissionsBloc>();

    return BlocBuilder<ClinicPermissionsBloc, ClinicPermissionsState>(
      bloc: bloc,
      builder: (context, state) {
        return state.when(
          initial: () => child,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_) => child,
          loaded: (permissions) {
            final slugs = anyOf ?? <String>[feature!];
            if (slugs.any(permissions.hasFeature)) {
              return child;
            }
            return _RestrictedView();
          },
        );
      },
    );
  }
}

class _RestrictedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final c = ColorManager.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: ColorManager.warning.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_outline_rounded,
                color: ColorManager.warning,
                size: 36.w,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              l10n.accessRestricted,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.accessRestrictedDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: fontFamily,
                color: c.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
