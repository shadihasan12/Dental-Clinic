import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/choose_clinic_name_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/choose_plan_page.dart';
import 'package:dental_clinic_app/features/home/presentation/pages/notification_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/add_treatment_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/pages/clinic_info_page.dart'
    show ClinicInfoPage;
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/presentation/pages/notifications_settings_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/presentation/pages/contact_support_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/presentation/pages/edit_profile_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/statistics/statistics_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/presentation/pages/support_chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/login_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/signup_page.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/patient_details_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/add_patient_page.dart';
import 'package:dental_clinic_app/features/appointments/presentation/pages/new_appointment_page.dart';
import 'package:dental_clinic_app/features/clinic/presentation/pages/staff_management_page.dart';
import 'package:dental_clinic_app/features/clinic/presentation/pages/invite_staff_page.dart';
import 'package:dental_clinic_app/features/clinic/presentation/pages/pending_approvals_page.dart';
import 'package:dental_clinic_app/features/clinic/presentation/pages/my_clinics_page.dart';
import 'package:dental_clinic_app/features/clinic/presentation/pages/create_clinic_page.dart';
import 'package:dental_clinic_app/features/subscription/presentation/pages/pricing_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Routes manager for the application using GoRouter
class RoutesManager {
  RoutesManager() {
    _appRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      // TODO: Change to /onboarding
      initialLocation: '/',
      routes: [
        // Onboarding
        GoRoute(
          path: '/onboarding',
          name: AppRoutesNames.onboarding,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const OnboardingPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        // Authentication Routes
        GoRoute(
          path: '/login',
          name: AppRoutesNames.login,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const LoginPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/register',
          name: AppRoutesNames.register,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const SignupPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/forgot-password',
          name: AppRoutesNames.forgotPassword,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const ForgotPasswordPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        GoRoute(
          path: '/choose-plan',
          name: AppRoutesNames.choosePlan,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const ChoosePlanPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        GoRoute(
          path: '/choose-clinic-name',
          name: AppRoutesNames.chooseClinicName,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: BlocProvider(
                create: (context) => AuthBloc(),
                child: const ChooseClinicNamePage(),
              ),
            );
          },
        ),

        // Main App (Root with Bottom Navigation)
        GoRoute(
          path: '/',
          name: AppRoutesNames.root,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const RootPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        // Patient Routes
        GoRoute(
          path: '/patients/add',
          name: AppRoutesNames.addPatient,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const AddPatientPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/patients-details',
          name: AppRoutesNames.patientDetails,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final patientId = extra["patientId"] as String;
            final patientName = extra["patientName"] as String? ?? '';
            final tabIndex = extra["tabIndex"] ?? 0;
            return CupertinoPage(
              child: PatientDetailsPage(
                patientId: patientId,
                patientName: patientName,
                tabIndex: tabIndex,
              ),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/add-treatment',
          name: AppRoutesNames.addTreatment,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final patientId = extra['patientId'] as String;
            final isInitial = extra['isInitial'] as bool? ?? false;
            return CupertinoPage(
              child: AddTreatmentPage(patientId: patientId, isInitial: isInitial),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        // Appointment Routes
        GoRoute(
          path: '/new-appointment',
          name: AppRoutesNames.newAppointment,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const NewAppointmentPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        // Clinic Management Routes
        GoRoute(
          path: '/clinic/:clinicId/staff',
          name: AppRoutesNames.staffManagement,
          pageBuilder: (context, state) {
            final clinicId = state.pathParameters['clinicId'] ?? '';
            return CupertinoPage(
              child: StaffManagementPage(clinicId: clinicId),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/clinic/invite-staff',
          name: AppRoutesNames.inviteStaff,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            return CupertinoPage(
              child: InviteStaffPage(
                clinicId: extra['clinicId'] ?? '',
                clinicName: extra['clinicName'] ?? '',
              ),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/clinic/:clinicId/approvals',
          name: AppRoutesNames.pendingApprovals,
          pageBuilder: (context, state) {
            final clinicId = state.pathParameters['clinicId'] ?? '';
            return CupertinoPage(
              child: PendingApprovalsPage(clinicId: clinicId),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        // Dentist Routes
        GoRoute(
          path: '/my-clinics',
          name: AppRoutesNames.myClinics,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const MyClinicsPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/create-clinic',
          name: AppRoutesNames.createClinic,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const CreateClinicPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        // Subscription Routes
        GoRoute(
          path: '/pricing',
          name: AppRoutesNames.pricing,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const PricingPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/statistics',
          name: AppRoutesNames.statistics,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const StatisticsPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/edit-profile',
          name: AppRoutesNames.editProfile,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const EditProfilePage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/clinic-info',
          name: AppRoutesNames.clinicInfo,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const ClinicInfoPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/contact-support',
          name: AppRoutesNames.contactSupport,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const ContactSupportPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/support-chat',
          name: AppRoutesNames.supportChat,
          pageBuilder: (context, state) {
            final conversation = state.extra as SupportConversationEntity;
            return CupertinoPage(
              child: SupportChatPage(conversation: conversation),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/notifications-settigns',
          name: AppRoutesNames.notificationsSettings,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const NotificationsSettingsPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/notifications',
          name: AppRoutesNames.notifications,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const NotificationPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
      ],
    );
  }

  late final GoRouter _appRouter;
  GoRouter get router => _appRouter;
}
