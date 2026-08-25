import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/invitation_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';

/// Bottom sheet for sending a clinic invitation. Validates locally, then
/// dispatches `sendInvitation` on the parent's [InvitationBloc].
class SendInviteSheet extends StatefulWidget {
  const SendInviteSheet({super.key});

  static Future<void> show(BuildContext context) {
    final bloc = context.read<InvitationBloc>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          BlocProvider.value(value: bloc, child: const SendInviteSheet()),
    );
  }

  @override
  State<SendInviteSheet> createState() => _SendInviteSheetState();
}

class _SendInviteSheetState extends State<SendInviteSheet> {
  final _emailCtrl = TextEditingController();
  final _selectedRoles = <String>{};

  // Roles that can be invited. ADMIN is left out — backends typically
  // restrict creating new admins to a different flow.
  static const _allRoles = ['DENTIST', 'SECRETARY'];

  bool get _canSend {
    final email = _emailCtrl.text.trim();
    return email.isNotEmpty &&
        _isValidEmail(email) &&
        _selectedRoles.isNotEmpty;
  }

  bool _isValidEmail(String email) {
    final re = RegExp(r'^[\w.\-+]+@[\w.\-]+\.[A-Za-z]{2,}$');
    return re.hasMatch(email);
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<InvitationBloc>().add(
      InvitationEvent.sendInvitation(
        email: _emailCtrl.text.trim(),
        roles: _selectedRoles.toList(),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, bottomInset + 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: c.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.sendInvite,
            style: TextStyle(
              fontSize: 17.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            l10n.sendInviteSubtitle,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: c.textTertiary,
            ),
          ),
          SizedBox(height: 20.h),

          Text(
            l10n.emailAddress,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: c.textSecondary,
            ),
          ),
          SizedBox(height: 6.h),
          TextField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            onChanged: (_) => setState(() {}),
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: c.textPrimary,
            ),
            decoration: formOutlinedInput(
              context,
              hintText: 'colleague@example.com',
            ),
          ),

          SizedBox(height: 16.h),
          Text(
            l10n.selectRoles,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w500,
              color: c.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _allRoles.map((role) {
              final selected = _selectedRoles.contains(role);
              return GestureDetector(
                onTap: () => setState(() {
                  selected
                      ? _selectedRoles.remove(role)
                      : _selectedRoles.add(role);
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? ColorManager.primary : c.inputBg,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: selected ? ColorManager.primary : c.borderLight,
                    ),
                  ),
                  child: Text(
                    _roleLabel(l10n, role),
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w500,
                      color: selected ? Colors.white : c.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 24.h),
          GestureDetector(
            onTap: _canSend ? _submit : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: _canSend ? ColorManager.primary : c.border,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                l10n.sendInvite,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _roleLabel(AppLocalizations l10n, String role) {
    switch (role) {
      case 'DENTIST':
        return l10n.roleDentist;
      case 'SECRETARY':
        return l10n.roleSecretary;
      default:
        return role;
    }
  }
}
