import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/new_treatment_plan_page.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/finish_profile_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/choose_plan_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/email_entry_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/verify_email_entry_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/home/presentation/pages/notification_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/add_treatment_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/pages/clinic_info_page.dart'
    show ClinicInfoPage;
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/pages/user_hours_page.dart'
    show UserHoursPage;
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/pages/working_days_page.dart'
    show WorkingDaysPage;
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/presentation/pages/notifications_settings_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/presentation/pages/contact_support_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/presentation/pages/change_email_otp_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/presentation/pages/change_email_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/presentation/pages/edit_profile_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/more_menu_page.dart';
import 'package:dental_clinic_app/features/statistics/presentation/pages/statistics_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/presentation/pages/support_chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/login_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/forgot_password_verify_otp_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/set_new_password_page.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/signup_page.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/patient_details_page.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/add_patient_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/edit_patient_page.dart';
import 'package:dental_clinic_app/features/appointments/presentation/pages/new_appointment_page.dart';
import 'package:dental_clinic_app/features/clinic/presentation/pages/pending_approvals_page.dart';
import 'package:dental_clinic_app/features/clinic/presentation/pages/my_clinics_page.dart';
import 'package:dental_clinic_app/features/clinic/presentation/pages/create_clinic_page.dart';
import 'package:dental_clinic_app/features/clinic/presentation/pages/clinic_users_page.dart';
import 'package:dental_clinic_app/features/subscription/presentation/pages/pricing_page.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/presentation/pages/billing_page.dart';
import 'package:dental_clinic_app/features/billing/presentation/pages/invoice_details_page.dart';
import 'package:dental_clinic_app/features/billing/presentation/pages/select_billing_plan_page.dart';
import 'package:dental_clinic_app/features/billing/presentation/pages/submit_payment_proof_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Routes manager for the application using GoRouter
class RoutesManager {
  RoutesManager(TokenStorage tokenStorage) {
    // Check if user is already authenticated
    final isAuthenticated = tokenStorage.hasToken();

    _appRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      // Navigate to home if authenticated, otherwise show onboarding
      initialLocation: isAuthenticated ? '/' : '/onboarding',
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
            // Get the AuthBloc from extra parameter if passed during navigation
            final authBloc = state.extra as AuthBloc?;
            return CupertinoPage(
              child: authBloc != null
                  ? BlocProvider<AuthBloc>.value(
                      value: authBloc,
                      child: const SignupPage(),
                    )
                  : const SignupPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/email-entry',
          name: AppRoutesNames.emailEntry,
          pageBuilder: (context, state) {
            final authBloc = state.extra as AuthBloc?;
            return CupertinoPage(
              child: authBloc != null
                  ? BlocProvider<AuthBloc>.value(
                      value: authBloc,
                      child: const EmailEntryPage(),
                    )
                  : BlocProvider(
                      create: (_) => getIt<AuthBloc>(),
                      child: const EmailEntryPage(),
                    ),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/verify-email-entry',
          name: AppRoutesNames.verifyEmailEntry,
          pageBuilder: (context, state) {
            final authBloc = state.extra as AuthBloc;
            return CupertinoPage(
              child: BlocProvider<AuthBloc>.value(
                value: authBloc,
                child: const VerifyEmailEntryPage(),
              ),
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
          path: '/forgot-password-verify-otp',
          name: AppRoutesNames.forgotPasswordVerifyOtp,
          pageBuilder: (context, state) {
            final authBloc = state.extra as AuthBloc;
            return CupertinoPage(
              child: BlocProvider<AuthBloc>.value(
                value: authBloc,
                child: const ForgotPasswordVerifyOtpPage(),
              ),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/set-new-password',
          name: AppRoutesNames.setNewPassword,
          pageBuilder: (context, state) {
            final authBloc = state.extra as AuthBloc;
            return CupertinoPage(
              child: BlocProvider<AuthBloc>.value(
                value: authBloc,
                child: const SetNewPasswordPage(),
              ),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        GoRoute(
          path: '/choose-plan',
          name: AppRoutesNames.choosePlan,
          pageBuilder: (context, state) {
            // Get the AuthBloc from extra parameter passed during navigation
            final authBloc = state.extra as AuthBloc;
            return CupertinoPage(
              child: BlocProvider<AuthBloc>.value(
                value: authBloc,
                child: const ChoosePlanPage(),
              ),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        GoRoute(
          path: '/choose-clinic-name',
          name: AppRoutesNames.chooseClinicName,
          pageBuilder: (context, state) {
            // Get the AuthBloc from extra parameter passed during navigation
            final authBloc = state.extra as AuthBloc;
            return CupertinoPage(
              child: BlocProvider<AuthBloc>.value(
                value: authBloc,
                child: const FinishProfilePage(),
              ),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),

        GoRoute(
          path: '/email-verification',
          name: AppRoutesNames.emailVerification,
          pageBuilder: (context, state) {
            // Get the AuthBloc from extra parameter passed during navigation
            final authBloc = state.extra as AuthBloc;
            return CupertinoPage(
              child: BlocProvider<AuthBloc>.value(
                value: authBloc,
                child: const VerifyOTPPage(),
              ),
              key: state.pageKey,
              name: state.name,
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
          path: '/patients/edit',
          name: AppRoutesNames.editPatient,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final patient = extra['patient'] as PatientEntity;
            return CupertinoPage(
              child: EditPatientPage(patient: patient),
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
            final prototypePlan = extra["prototypePlan"] as TreatmentPlan?;
            return CupertinoPage(
              child: PatientDetailsPage(
                patientId: patientId,
                patientName: patientName,
                tabIndex: tabIndex,
                prototypePlan: prototypePlan,
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
            final caseId = extra['caseId'] as String?;
            final patientName = extra['patientName'] as String? ?? '';

            if (isInitial && caseId == null) {
              return CupertinoPage(
                child: NewTreatmentPlanPage(
                  patientId: patientId,
                  patientName: patientName,
                ),
                key: state.pageKey,
                name: state.name,
              );
            }

            return CupertinoPage(
              child: AddTreatmentPage(
                patientId: patientId,
                isInitial: isInitial,
                caseId: caseId,
              ),
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
        GoRoute(
          path: '/clinic-users',
          name: AppRoutesNames.clinicUsers,
          pageBuilder: (context, state) {
            final clinicId = state.extra as String? ?? '';
            return CupertinoPage(
              child: ClinicUsersPage(clinicId: clinicId),
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

        // Billing Routes
        GoRoute(
          path: '/billing',
          name: AppRoutesNames.billing,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const BillingPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/billing/select-plan',
          name: AppRoutesNames.selectBillingPlan,
          pageBuilder: (context, state) {
            final isRenewal = (state.extra as bool?) ?? false;
            return CupertinoPage(
              child: SelectBillingPlanPage(isRenewal: isRenewal),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/billing/invoice',
          name: AppRoutesNames.invoiceDetails,
          pageBuilder: (context, state) {
            final invoice = state.extra as InvoiceEntity;
            return CupertinoPage(
              child: InvoiceDetailsPage(invoice: invoice),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/billing/submit-proof',
          name: AppRoutesNames.submitPaymentProof,
          pageBuilder: (context, state) {
            final invoice = state.extra as InvoiceEntity;
            return CupertinoPage(
              child: SubmitPaymentProofPage(invoice: invoice),
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
          path: '/more',
          name: AppRoutesNames.moreMenu,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const MenuPage(),
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
          path: '/working-days',
          name: AppRoutesNames.workingDays,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const WorkingDaysPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/clinic-users/:userId/hours',
          name: AppRoutesNames.userHours,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return CupertinoPage(
              child: UserHoursPage(
                userId: state.pathParameters['userId']!,
                userName: extra?['userName'] as String?,
              ),
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
        // Change Email
        GoRoute(
          path: '/change-email',
          name: AppRoutesNames.changeEmail,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            final currentEmail = extra['currentEmail'] as String? ?? '';
            return CupertinoPage(
              child: ChangeEmailPage(currentEmail: currentEmail),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/change-email-otp',
          name: AppRoutesNames.changeEmailOtpPage,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            final newEmail = extra['newEmail'] as String? ?? '';
            final sessionId = extra['sessionId'] as String?;
            final secondsRemaining = extra['secondsRemaining'] as int? ?? 60;
            return CupertinoPage(
              child: ChangeEmailOtpPage(
                newEmail: newEmail,
                sessionId: sessionId,
                secondsRemaining: secondsRemaining,
              ),
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
