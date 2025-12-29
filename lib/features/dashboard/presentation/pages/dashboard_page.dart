import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:dental_clinic_app/features/subscription/presentation/widgets/subscription_status_card.dart';
import '../widgets/widgets.dart';

/// Main dashboard page showing overview of clinic metrics and schedule
/// Adapts based on user's context:
/// - If user owns a clinic → Shows clinic management
/// - If user doesn't own a clinic → Shows "Create Practice" prompt
/// - Shows pending invitations regardless of ownership
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // =========================================================================
  // MOCK DATA - Replace with BLoC state in production
  // =========================================================================
  // TODO: Integrate with AuthBloc and ClinicBloc
  // TODO: Integrate with SubscriptionBloc
  // TODO: Integrate with InvitationBloc

  final String _userName = 'Dr. Smith';
  final bool _ownsClinic = true; // From AuthBloc: authState.ownsClinic
  final String _ownedClinicName = 'Bright Smile Dental';
  final String _ownedClinicId = 'clinic_123';
  final int _staffCount = 5;
  final int _pendingApprovalsCount = 2;
  final int _membershipCount = 2;

  final List<PendingInvitationData> _pendingInvitations = const [
    PendingInvitationData(
      id: '1',
      clinicName: 'City Dental Care',
      role: 'Dentist',
      inviterName: 'Dr. Johnson',
    ),
  ];

  UserSubscriptionEntity? _subscription;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _subscription = UserSubscriptionEntity(
      id: 'sub_123',
      userId: 'user_123',
      planTier: PlanTier.trial,
      status: SubscriptionStatus.trial,
      billingCycle: BillingCycle.monthly,
      startDate: now,
      currentPeriodEnd: now.add(const Duration(days: 7)),
      trialEndDate: now.add(const Duration(days: 7)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(
              userName: _userName,
              portalType: _ownsClinic ? 'Clinic Owner' : 'Dental Professional',
              clinicName: _ownsClinic ? _ownedClinicName : null,
              isClinicAccount: _ownsClinic,
            ),
            // Stats grid overlapping header
            Transform.translate(
              offset: Offset(0, -24.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const StatsGrid(),
              ),
            ),


            // Context-based sections
            if (_ownsClinic) ...[
              // User owns a clinic - show management section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _buildClinicManagementSection(),
              ),
            ] else ...[
              // User doesn't own a clinic - show create practice prompt
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _buildCreatePracticeCard(),
              ),
            ],
            SizedBox(height: 16.h),

            // My Clinics section (memberships + invitations)
            if (!_ownsClinic || _pendingInvitations.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _buildMyClinicsSection(),
              ),
            if (!_ownsClinic || _pendingInvitations.isNotEmpty)
              SizedBox(height: 16.h),

            // Subscription status card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SubscriptionStatusCard(
                subscription: _subscription,
                onUpgrade: () {
                  context.pushNamed(AppRoutesNames.pricing);
                },
                onManage: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Manage subscription coming soon')),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),

            // Quick actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: QuickActions(
                onAddPatient: () => context.pushNamed(AppRoutesNames.addPatient),
                onScheduleVisit: () => context.pushNamed(AppRoutesNames.bookAppointment),
                onNewCase: () {},
                onRecordPayment: () {},
              ),
            ),
            SizedBox(height: 16.h),

            // Today's schedule
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TodaysSchedule(onViewAllTap: () {}),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }


  /// Card prompting user to create their own practice
  Widget _buildCreatePracticeCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: GradientManager.primaryHeader,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: ColorManager.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.add_business,
                  color: ColorManager.white,
                  size: 26.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Your Practice',
                      style: TextStyleManager.titleMedium.copyWith(
                        color: ColorManager.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Create your clinic and start managing patients, appointments, and staff.',
                      style: TextStyleManager.bodySmall.copyWith(
                        color: ColorManager.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.pushNamed(AppRoutesNames.createClinic),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.white,
                foregroundColor: ColorManager.primary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: const Text('Create My Practice'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicManagementSection() {
    return ClinicManagementSection(
      clinicName: _ownedClinicName,
      staffCount: _staffCount,
      pendingApprovalsCount: _pendingApprovalsCount,
      onManageStaff: () {
        context.pushNamed(
          AppRoutesNames.staffManagement,
          pathParameters: {'clinicId': _ownedClinicId},
        );
      },
      onPendingApprovals: () {
        context.pushNamed(
          AppRoutesNames.pendingApprovals,
          pathParameters: {'clinicId': _ownedClinicId},
        );
      },
      onInviteStaff: () {
        context.pushNamed(
          AppRoutesNames.inviteStaff,
          extra: {
            'clinicId': _ownedClinicId,
            'clinicName': _ownedClinicName,
          },
        );
      },
    );
  }

  Widget _buildMyClinicsSection() {
    return MyClinicsSection(
      clinicsCount: _membershipCount,
      pendingInvitations: _pendingInvitations,
      onViewAllClinics: () {
        context.pushNamed(AppRoutesNames.myClinics);
      },
      onAcceptInvitation: (invitationId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Accepted invitation $invitationId')),
        );
      },
      onRejectInvitation: (invitationId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rejected invitation $invitationId')),
        );
      },
    );
  }
}
