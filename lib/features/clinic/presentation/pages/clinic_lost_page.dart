import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/session/session_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/adaptive_content_width.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/get_my_clinics_use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/switch_active_clinic_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/clinic_access/clinic_access_guard.dart';
import 'package:dental_clinic_app/services/clinic_access/clinic_lost_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// "You are no longer a member of this clinic" - shown once the open clinic
/// stopped being the user's, and impossible to back out of into it.
///
/// It says why (the notice's own words, or neutral copy after a refusal,
/// which does not say whether they were removed or the clinic closed), then
/// asks where to go: the clinics they still have, or - with none left - the
/// "no clinic" screen. Never a log-out on its own: the account still signs
/// in, and may open a clinic of its own.
class ClinicLostPage extends StatefulWidget {
  const ClinicLostPage({super.key, this.args = const ClinicLostArgs()});

  final ClinicLostArgs args;

  @override
  State<ClinicLostPage> createState() => _ClinicLostPageState();
}

class _ClinicLostPageState extends State<ClinicLostPage> {
  List<ClinicMembershipEntity>? _clinics;
  NetworkExceptions? _error;
  bool _loading = true;
  bool _switching = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = await getIt<GetMyClinicsUseCase>()();
    if (!mounted) return;

    final clinics = result.fold((_) => null, (c) => c);
    if (clinics != null && clinics.isEmpty) {
      // None left: not a log-out - the account can open its own clinic or
      // accept an invitation.
      getIt<ClinicAccessGuard>().leavingOpenClinic = false;
      context.goNamed(AppRoutesNames.noClinic);
      return;
    }
    setState(() {
      _loading = false;
      _clinics = clinics;
      _error = result.fold((e) => e, (_) => null);
    });
  }

  Future<void> _open(ClinicMembershipEntity membership) async {
    if (_switching) return;
    setState(() => _switching = true);
    // The same path as any clinic switch: header, cached role, permissions,
    // every tab remounted against the new clinic.
    await getIt<SwitchActiveClinicUseCase>().activate(membership);
    getIt<ClinicAccessGuard>().leavingOpenClinic = false;
    if (!mounted) return;
    context.goNamed(AppRoutesNames.root);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final args = widget.args;

    final title = (args.title?.isNotEmpty ?? false)
        ? args.title!
        : l10n.clinicLostTitle;
    final message = (args.message?.isNotEmpty ?? false)
        ? args.message!
        : (args.clinicName?.isNotEmpty ?? false)
            ? l10n.clinicLostMessage(args.clinicName!)
            : l10n.clinicLostMessageNoName;

    return PopScope(
      // Back would lead into the clinic that is no longer theirs.
      canPop: false,
      child: Scaffold(
        backgroundColor: c.scaffoldBg,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 24.h),
            child: AdaptiveContentWidth(
              maxWidth: 520,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: IconTile(
                      icon: Icons.domain_disabled_rounded,
                      tone: ColorManager.error,
                      size: 56.w,
                      iconSize: 28.w,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 13.sp,
                      height: 1.5,
                      color: c.textSecondary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ..._body(l10n, c, family),
                  SizedBox(height: 16.h),
                  DentaOutlineButton(
                    label: l10n.logout,
                    icon: Icons.logout_rounded,
                    expand: true,
                    tone: ColorManager.error,
                    onTap: _switching
                        ? null
                        : () => getIt<SessionManager>().endSession(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _body(AppLocalizations l10n, AppColors c, String family) {
    if (_loading) {
      return [
        for (var i = 0; i < 2; i++) ...[
          ShimmerBox(
            width: double.infinity,
            height: 60.h,
            radius: BorderRadius.circular(14.r),
          ),
          SizedBox(height: 8.h),
        ],
      ];
    }

    final error = _error;
    if (error != null) {
      return [
        StateCard(
          icon: Icons.cloud_off_rounded,
          tone: ColorManager.error,
          title: l10n.couldNotLoadClinics,
          message: NetworkExceptions.getErrorMessage(error),
          actionLabel: l10n.retry,
          onAction: _load,
        ),
      ];
    }

    return [
      Text(
        l10n.clinicLostChoose,
        style: TextStyle(
          fontFamily: family,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: c.textTertiary,
        ),
      ),
      SizedBox(height: 8.h),
      for (final m in _clinics ?? const <ClinicMembershipEntity>[]) ...[
        AppCard(
          onTap: _switching ? null : () => _open(m),
          child: Row(
            children: [
              const IconTile(icon: Icons.local_hospital_outlined),
              SizedBox(width: 11.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.clinicName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _roleLabel(l10n, m.role),
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 11.5.sp,
                        color: c.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.chevron_left_rounded
                    : Icons.chevron_right_rounded,
                color: c.textTertiary,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
      ],
    ];
  }

  static String _roleLabel(AppLocalizations l10n, ClinicRole role) {
    switch (role) {
      case ClinicRole.admin:
        return l10n.roleAdmin;
      case ClinicRole.dentist:
        return l10n.roleDentist;
      case ClinicRole.secretary:
        return l10n.roleSecretary;
      case ClinicRole.receptionist:
        return l10n.roleReceptionist;
    }
  }
}
