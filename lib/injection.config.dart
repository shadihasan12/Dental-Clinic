// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i163;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'core/api/api_consumer.dart' as _i962;
import 'core/api/dio_consumer.dart' as _i737;
import 'core/api/interceptors/auth_interceptor.dart' as _i240;
import 'core/api/interceptors/error_interceptor.dart' as _i809;
import 'core/api/interceptors/logging_interceptor.dart' as _i416;
import 'core/di/bloc_injection.dart' as _i732;
import 'core/di/third_party_injection.dart' as _i1007;
import 'core/localization/language_bloc.dart' as _i924;
import 'core/localization/language_service.dart' as _i934;
import 'core/network/network_info.dart' as _i75;
import 'core/services/notifications/notification_poller.dart' as _i614;
import 'core/services/notifications/notification_service.dart' as _i40;
import 'core/services/notifications/notification_topics_synchronizer.dart'
    as _i132;
import 'core/session/session_manager.dart' as _i204;
import 'core/storage/token_storage.dart' as _i23;
import 'core/storage/user_storage.dart' as _i663;
import 'core/theme/theme_bloc.dart' as _i909;
import 'core/theme/theme_service.dart' as _i275;
import 'features/appointments/data/data_sources/appointment_remote_data_source.dart'
    as _i41;
import 'features/appointments/data/repositories/appointment_repository_impl.dart'
    as _i71;
import 'features/appointments/domain/repositories/appointment_repository.dart'
    as _i675;
import 'features/appointments/domain/use_cases/create_appointment_use_case.dart'
    as _i213;
import 'features/appointments/domain/use_cases/get_all_appointments_use_case.dart'
    as _i791;
import 'features/appointments/domain/use_cases/get_available_slots_use_case.dart'
    as _i210;
import 'features/appointments/domain/use_cases/get_clinic_doctors_use_case.dart'
    as _i827;
import 'features/appointments/domain/use_cases/update_appointment_status_use_case.dart'
    as _i942;
import 'features/appointments/presentation/manager/appointment_bloc.dart'
    as _i675;
import 'features/auth/data/datasources/remote/auth_remote_data_source.dart'
    as _i689;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i363;
import 'features/billing/data/data_sources/billing_local_data_source.dart'
    as _i733;
import 'features/billing/data/payment_providers/manual_payment_provider.dart'
    as _i776;
import 'features/billing/data/repositories/billing_repository_impl.dart'
    as _i982;
import 'features/billing/domain/payment_providers/payment_provider.dart'
    as _i349;
import 'features/billing/domain/repositories/billing_repository.dart' as _i862;
import 'features/billing/domain/use_cases/create_invoice_use_case.dart'
    as _i321;
import 'features/billing/domain/use_cases/list_invoices_use_case.dart' as _i409;
import 'features/billing/domain/use_cases/submit_payment_proof_use_case.dart'
    as _i212;
import 'features/billing/presentation/bloc/billing_bloc.dart' as _i755;
import 'features/clinic/data/data_sources/clinic_remote_data_source.dart'
    as _i190;
import 'features/clinic/data/repositories/clinic_repository_impl.dart' as _i968;
import 'features/clinic/domain/repositories/clinic_repository.dart' as _i818;
import 'features/clinic/domain/use_cases/add_clinic_user_use_case.dart'
    as _i166;
import 'features/clinic/domain/use_cases/get_clinic_users_use_case.dart'
    as _i398;
import 'features/clinic/domain/use_cases/get_my_clinics_use_case.dart' as _i113;
import 'features/clinic/domain/use_cases/get_received_invitations_use_case.dart'
    as _i860;
import 'features/clinic/domain/use_cases/get_sent_invitations_use_case.dart'
    as _i675;
import 'features/clinic/domain/use_cases/remove_clinic_user_use_case.dart'
    as _i223;
import 'features/clinic/domain/use_cases/respond_to_invitation_use_case.dart'
    as _i945;
import 'features/clinic/domain/use_cases/send_invitation_use_case.dart' as _i21;
import 'features/clinic/domain/use_cases/update_user_roles_use_case.dart'
    as _i972;
import 'features/clinic/presentation/bloc/clinic_users_bloc.dart' as _i475;
import 'features/clinic/presentation/bloc/invitation_bloc.dart' as _i932;
import 'features/clinic/presentation/bloc/my_clinics_bloc.dart' as _i533;
import 'features/expenses/data/data_sources/expense_remote_data_source.dart'
    as _i355;
import 'features/expenses/data/repositories/expense_repository_impl.dart'
    as _i792;
import 'features/expenses/domain/repositories/expense_repository.dart' as _i18;
import 'features/expenses/domain/use_cases/add_expense_use_case.dart' as _i841;
import 'features/expenses/domain/use_cases/delete_expense_use_case.dart'
    as _i526;
import 'features/expenses/domain/use_cases/get_all_expenses_use_case.dart'
    as _i66;
import 'features/expenses/domain/use_cases/get_categories_use_case.dart'
    as _i342;
import 'features/expenses/domain/use_cases/update_expense_use_case.dart'
    as _i315;
import 'features/expenses/presentation/manager/expense_bloc.dart' as _i763;
import 'features/home/data/data_sources/fcm_token_remote_data_source.dart'
    as _i188;
import 'features/home/data/data_sources/notification_remote_data_source.dart'
    as _i573;
import 'features/home/data/repositories/fcm_token_repository_impl.dart'
    as _i269;
import 'features/home/data/repositories/notification_repository_impl.dart'
    as _i20;
import 'features/home/domain/repositories/fcm_token_repository.dart' as _i109;
import 'features/home/domain/repositories/notification_repository.dart' as _i4;
import 'features/home/domain/use_cases/get_notifications_use_case.dart'
    as _i342;
import 'features/home/domain/use_cases/get_unread_count_use_case.dart' as _i874;
import 'features/home/domain/use_cases/get_unseen_notifications_use_case.dart'
    as _i453;
import 'features/home/domain/use_cases/logout_device_use_case.dart' as _i939;
import 'features/home/domain/use_cases/mark_all_notifications_as_read_use_case.dart'
    as _i1060;
import 'features/home/domain/use_cases/mark_notification_as_read_use_case.dart'
    as _i818;
import 'features/home/domain/use_cases/mark_notification_as_unread_use_case.dart'
    as _i519;
import 'features/home/domain/use_cases/mark_notifications_seen_use_case.dart'
    as _i219;
import 'features/home/domain/use_cases/register_fcm_token_use_case.dart'
    as _i928;
import 'features/home/presentation/manager/notification_bloc.dart' as _i347;
import 'features/home/presentation/manager/unread_count_cubit.dart' as _i103;
import 'features/patients/data/data_sources/patient_remote_data_source.dart'
    as _i536;
import 'features/patients/data/repositories/patient_repository_impl.dart'
    as _i504;
import 'features/patients/domain/repositories/patient_repository.dart' as _i192;
import 'features/patients/domain/use_cases/add_patient_use_case.dart' as _i594;
import 'features/patients/domain/use_cases/add_payment_use_case.dart' as _i924;
import 'features/patients/domain/use_cases/add_treatment_use_case.dart'
    as _i208;
import 'features/patients/domain/use_cases/detach_patient_use_case.dart'
    as _i479;
import 'features/patients/domain/use_cases/get_all_core_treatments_use_case.dart'
    as _i931;
import 'features/patients/domain/use_cases/get_all_patients_use_case.dart'
    as _i281;
import 'features/patients/domain/use_cases/get_all_teeth_use_case.dart'
    as _i126;
import 'features/patients/domain/use_cases/get_patient_cases_use_case.dart'
    as _i129;
import 'features/patients/domain/use_cases/get_patient_details_use_case.dart'
    as _i1063;
import 'features/patients/domain/use_cases/get_payments_use_case.dart' as _i773;
import 'features/patients/domain/use_cases/mark_case_as_finished_use_case.dart'
    as _i920;
import 'features/patients/domain/use_cases/update_patient_use_case.dart'
    as _i496;
import 'features/patients/presentation/manager/add_patient/add_patient_bloc.dart'
    as _i527;
import 'features/patients/presentation/manager/add_treatment/add_treatment_bloc.dart'
    as _i154;
import 'features/patients/presentation/manager/list_patients/patients_list_bloc.dart'
    as _i833;
import 'features/patients/presentation/manager/patient_details/patient_details_bloc.dart'
    as _i548;
import 'features/profile/presentation/pages/clinic_info/data/data_sources/clinic_info_remote_data_source.dart'
    as _i485;
import 'features/profile/presentation/pages/clinic_info/data/data_sources/working_days_remote_data_source.dart'
    as _i369;
import 'features/profile/presentation/pages/clinic_info/data/repositories/clinic_info_repository_impl.dart'
    as _i841;
import 'features/profile/presentation/pages/clinic_info/data/repositories/working_days_repository_impl.dart'
    as _i987;
import 'features/profile/presentation/pages/clinic_info/domain/repositories/clinic_info_repository.dart'
    as _i1027;
import 'features/profile/presentation/pages/clinic_info/domain/repositories/working_days_repository.dart'
    as _i971;
import 'features/profile/presentation/pages/clinic_info/domain/use_cases/get_clinic_info_use_case.dart'
    as _i127;
import 'features/profile/presentation/pages/clinic_info/domain/use_cases/update_clinic_info_use_case.dart'
    as _i8;
import 'features/profile/presentation/pages/clinic_info/presentation/manager/clinic_info_bloc.dart'
    as _i506;
import 'features/profile/presentation/pages/clinic_info/presentation/manager/user_hours_bloc.dart'
    as _i13;
import 'features/profile/presentation/pages/clinic_info/presentation/manager/working_days_bloc.dart'
    as _i526;
import 'features/profile/presentation/pages/edit_profile/data/data_sources/edit_profile_remote_data_source.dart'
    as _i423;
import 'features/profile/presentation/pages/edit_profile/data/repositories/edit_profile_repository_impl.dart'
    as _i489;
import 'features/profile/presentation/pages/edit_profile/domain/repositories/edit_profile_repository.dart'
    as _i274;
import 'features/profile/presentation/pages/edit_profile/domain/use_cases/get_user_profile_use_case.dart'
    as _i527;
import 'features/profile/presentation/pages/edit_profile/domain/use_cases/update_user_profile_use_case.dart'
    as _i494;
import 'features/profile/presentation/pages/edit_profile/presentation/manager/edit_profile_bloc.dart'
    as _i890;
import 'features/profile/presentation/pages/issues/data/data_sources/issue_remote_data_source.dart'
    as _i76;
import 'features/profile/presentation/pages/issues/data/repositories/issue_repository_impl.dart'
    as _i679;
import 'features/profile/presentation/pages/issues/domain/repositories/issue_repository.dart'
    as _i426;
import 'features/profile/presentation/pages/issues/domain/use_cases/create_issue_use_case.dart'
    as _i839;
import 'features/profile/presentation/pages/issues/domain/use_cases/get_issues_use_case.dart'
    as _i239;
import 'features/profile/presentation/pages/issues/presentation/manager/issues_bloc.dart'
    as _i732;
import 'features/profile/presentation/pages/notifications_settngs/data/data_sources/notification_settings_remote_data_source.dart'
    as _i806;
import 'features/profile/presentation/pages/notifications_settngs/data/repositories/notification_settings_repository_impl.dart'
    as _i395;
import 'features/profile/presentation/pages/notifications_settngs/domain/repositories/notification_settings_repository.dart'
    as _i455;
import 'features/profile/presentation/pages/notifications_settngs/domain/use_cases/get_notification_settings_use_case.dart'
    as _i275;
import 'features/profile/presentation/pages/notifications_settngs/domain/use_cases/update_notification_settings_use_case.dart'
    as _i237;
import 'features/profile/presentation/pages/notifications_settngs/presentation/manager/notification_settings_bloc.dart'
    as _i493;
import 'features/statistics/data/data_sources/statistics_catalog_remote_data_source.dart'
    as _i630;
import 'features/statistics/data/repositories/statistics_catalog_repository_impl.dart'
    as _i591;
import 'features/statistics/domain/repositories/statistics_catalog_repository.dart'
    as _i850;
import 'features/statistics/presentation/bloc/statistics_dashboard_bloc.dart'
    as _i25;
import 'features/subscription/data/data_sources/subscription_remote_data_source.dart'
    as _i151;
import 'features/subscription/data/repositories/subscription_repository_impl.dart'
    as _i155;
import 'features/subscription/domain/repositories/subscription_repository.dart'
    as _i900;
import 'features/subscription/domain/use_cases/get_plans_use_case.dart'
    as _i779;
import 'features/subscription/domain/use_cases/get_subscription_status_use_case.dart'
    as _i473;
import 'features/subscription/domain/use_cases/get_subscription_usage_use_case.dart'
    as _i989;
import 'features/subscription/presentation/bloc/subscription_bloc.dart'
    as _i1011;
import 'services/currency/currency_bloc.dart' as _i46;
import 'services/currency/currency_service.dart' as _i315;
import 'services/file_picker/file_picker_service.dart' as _i525;
import 'services/media/media_service.dart' as _i977;
import 'services/permissions/clinic_permissions_bloc.dart' as _i1052;
import 'services/permissions/clinic_permissions_service.dart' as _i252;
import 'services/subscription_guard/subscription_guard.dart' as _i821;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyInjection = _$ThirdPartyInjection();
    final blocInjection = _$BlocInjection();
    gh.singleton<_i809.ErrorInterceptor>(() => _i809.ErrorInterceptor());
    gh.singleton<_i416.LoggingInterceptor>(() => _i416.LoggingInterceptor());
    gh.singleton<_i361.Dio>(() => thirdPartyInjection.dio);
    gh.singleton<_i973.InternetConnectionChecker>(
      () => thirdPartyInjection.internetConnectionChecker,
    );
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => thirdPartyInjection.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i892.FirebaseMessaging>(
      () => thirdPartyInjection.firebaseMessaging,
    );
    gh.singleton<_i163.FlutterLocalNotificationsPlugin>(
      () => thirdPartyInjection.flutterLocalNotificationsPlugin,
    );
    gh.lazySingleton<_i525.FilePickerService>(() => _i525.FilePickerService());
    gh.lazySingleton<_i821.SubscriptionGuard>(() => _i821.SubscriptionGuard());
    gh.factory<_i23.TokenStorage>(
      () => _i23.TokenStorage(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i663.UserStorage>(
      () => _i663.UserStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i733.BillingLocalDataSource>(
      () => _i733.InMemoryBillingDataSource(),
    );
    gh.lazySingleton<_i349.PaymentProvider>(
      () => _i776.ManualPaymentProvider(gh<_i733.BillingLocalDataSource>()),
    );
    gh.lazySingleton<_i75.NetworkInfo>(
      () => _i75.NetworkInfoImpl(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.lazySingleton<_i204.SessionManager>(
      () => _i204.SessionManager(
        gh<_i23.TokenStorage>(),
        gh<_i663.UserStorage>(),
      ),
    );
    gh.lazySingleton<_i934.LanguageService>(
      () => blocInjection.languageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i275.ThemeService>(
      () => blocInjection.themeService(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i862.BillingRepository>(
      () => _i982.BillingRepositoryImpl(
        gh<_i733.BillingLocalDataSource>(),
        gh<_i349.PaymentProvider>(),
        gh<_i821.SubscriptionGuard>(),
      ),
    );
    gh.lazySingleton<_i909.ThemeBloc>(
      () => blocInjection.themeBloc(gh<_i275.ThemeService>()),
    );
    gh.factory<_i321.CreateInvoiceUseCase>(
      () => _i321.CreateInvoiceUseCase(gh<_i862.BillingRepository>()),
    );
    gh.factory<_i409.ListInvoicesUseCase>(
      () => _i409.ListInvoicesUseCase(gh<_i862.BillingRepository>()),
    );
    gh.factory<_i212.SubmitPaymentProofUseCase>(
      () => _i212.SubmitPaymentProofUseCase(gh<_i862.BillingRepository>()),
    );
    gh.singleton<_i240.AuthInterceptor>(
      () => _i240.AuthInterceptor(
        gh<_i23.TokenStorage>(),
        gh<_i934.LanguageService>(),
        gh<_i204.SessionManager>(),
      ),
    );
    gh.singleton<_i962.ApiConsumer>(
      () => _i737.DioConsumer(
        gh<_i361.Dio>(),
        gh<_i240.AuthInterceptor>(),
        gh<_i809.ErrorInterceptor>(),
        gh<_i416.LoggingInterceptor>(),
      ),
    );
    gh.factory<_i755.BillingBloc>(
      () => _i755.BillingBloc(
        listInvoices: gh<_i409.ListInvoicesUseCase>(),
        createInvoice: gh<_i321.CreateInvoiceUseCase>(),
        submitProof: gh<_i212.SubmitPaymentProofUseCase>(),
        repository: gh<_i862.BillingRepository>(),
      ),
    );
    gh.factory<_i689.AuthRemoteDataSource>(
      () => _i689.AuthRemoteDataSourceImpl(
        gh<_i962.ApiConsumer>(),
        gh<_i23.TokenStorage>(),
        gh<_i663.UserStorage>(),
      ),
    );
    gh.factory<_i573.NotificationRemoteDataSource>(
      () => _i573.NotificationRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i1015.AuthRepository>(
      () => _i111.AuthRepositoryImpl(
        gh<_i689.AuthRemoteDataSource>(),
        gh<_i75.NetworkInfo>(),
      ),
    );
    gh.factory<_i485.ClinicInfoRemoteDataSource>(
      () => _i485.ClinicInfoRemoteDataSourceImpl(
        gh<_i962.ApiConsumer>(),
        gh<_i663.UserStorage>(),
      ),
    );
    gh.factory<_i806.NotificationSettingsRemoteDataSource>(
      () => _i806.NotificationSettingsRemoteDataSourceImpl(
        gh<_i962.ApiConsumer>(),
      ),
    );
    gh.factory<_i423.EditProfileRemoteDataSource>(
      () => _i423.EditProfileRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i41.AppointmentRemoteDataSource>(
      () => _i41.AppointmentRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i630.StatisticsCatalogRemoteDataSource>(
      () =>
          _i630.StatisticsCatalogRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i369.WorkingDaysRemoteDataSource>(
      () => _i369.WorkingDaysRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.lazySingleton<_i315.CurrencyService>(
      () => _i315.CurrencyService(gh<_i962.ApiConsumer>()),
    );
    gh.lazySingleton<_i977.MediaService>(
      () => _i977.MediaService(gh<_i962.ApiConsumer>()),
    );
    gh.lazySingleton<_i252.ClinicPermissionsService>(
      () => _i252.ClinicPermissionsService(gh<_i962.ApiConsumer>()),
    );
    gh.lazySingleton<_i355.ExpenseRemoteDataSource>(
      () => _i355.ExpenseRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.lazySingleton<_i536.PatientRemoteDataSource>(
      () => _i536.PatientRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i76.IssueRemoteDataSource>(
      () => _i76.IssueRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i455.NotificationSettingsRepository>(
      () => _i395.NotificationSettingsRepositoryImpl(
        gh<_i806.NotificationSettingsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1052.ClinicPermissionsBloc>(
      () => _i1052.ClinicPermissionsBloc(gh<_i252.ClinicPermissionsService>()),
    );
    gh.lazySingleton<_i190.ClinicRemoteDataSource>(
      () => _i190.ClinicRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i188.FcmTokenRemoteDataSource>(
      () => _i188.FcmTokenRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i151.SubscriptionRemoteDataSource>(
      () => _i151.SubscriptionRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i818.ClinicRepository>(
      () => _i968.ClinicRepositoryImpl(gh<_i190.ClinicRemoteDataSource>()),
    );
    gh.factory<_i275.GetNotificationSettingsUseCase>(
      () => _i275.GetNotificationSettingsUseCase(
        gh<_i455.NotificationSettingsRepository>(),
      ),
    );
    gh.factory<_i237.UpdateNotificationSettingUseCase>(
      () => _i237.UpdateNotificationSettingUseCase(
        gh<_i455.NotificationSettingsRepository>(),
      ),
    );
    gh.factory<_i4.NotificationRepository>(
      () => _i20.NotificationRepositoryImpl(
        gh<_i573.NotificationRemoteDataSource>(),
      ),
    );
    gh.factory<_i109.FcmTokenRepository>(
      () => _i269.FcmTokenRepositoryImpl(gh<_i188.FcmTokenRemoteDataSource>()),
    );
    gh.factory<_i426.IssueRepository>(
      () => _i679.IssueRepositoryImpl(gh<_i76.IssueRemoteDataSource>()),
    );
    gh.factory<_i850.StatisticsCatalogRepository>(
      () => _i591.StatisticsCatalogRepositoryImpl(
        gh<_i630.StatisticsCatalogRemoteDataSource>(),
      ),
    );
    gh.factory<_i839.CreateIssueUseCase>(
      () => _i839.CreateIssueUseCase(gh<_i426.IssueRepository>()),
    );
    gh.factory<_i239.GetIssuesUseCase>(
      () => _i239.GetIssuesUseCase(gh<_i426.IssueRepository>()),
    );
    gh.factory<_i900.SubscriptionRepository>(
      () => _i155.SubscriptionRepositoryImpl(
        gh<_i151.SubscriptionRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i46.CurrencyBloc>(
      () => _i46.CurrencyBloc(gh<_i315.CurrencyService>()),
    );
    gh.factory<_i192.PatientRepository>(
      () => _i504.PatientRepositoryImpl(gh<_i536.PatientRemoteDataSource>()),
    );
    gh.factory<_i342.GetNotificationsUseCase>(
      () => _i342.GetNotificationsUseCase(gh<_i4.NotificationRepository>()),
    );
    gh.factory<_i874.GetUnreadCountUseCase>(
      () => _i874.GetUnreadCountUseCase(gh<_i4.NotificationRepository>()),
    );
    gh.factory<_i453.GetUnseenNotificationsUseCase>(
      () =>
          _i453.GetUnseenNotificationsUseCase(gh<_i4.NotificationRepository>()),
    );
    gh.factory<_i1060.MarkAllNotificationsAsReadUseCase>(
      () => _i1060.MarkAllNotificationsAsReadUseCase(
        gh<_i4.NotificationRepository>(),
      ),
    );
    gh.factory<_i219.MarkNotificationsSeenUseCase>(
      () =>
          _i219.MarkNotificationsSeenUseCase(gh<_i4.NotificationRepository>()),
    );
    gh.factory<_i818.MarkNotificationAsReadUseCase>(
      () =>
          _i818.MarkNotificationAsReadUseCase(gh<_i4.NotificationRepository>()),
    );
    gh.factory<_i519.MarkNotificationAsUnreadUseCase>(
      () => _i519.MarkNotificationAsUnreadUseCase(
        gh<_i4.NotificationRepository>(),
      ),
    );
    gh.factory<_i18.ExpenseRepository>(
      () => _i792.ExpenseRepositoryImpl(gh<_i355.ExpenseRemoteDataSource>()),
    );
    gh.factory<_i1027.ClinicInfoRepository>(
      () => _i841.ClinicInfoRepositoryImpl(
        gh<_i485.ClinicInfoRemoteDataSource>(),
      ),
    );
    gh.factory<_i274.EditProfileRepository>(
      () => _i489.EditProfileRepositoryImpl(
        gh<_i423.EditProfileRemoteDataSource>(),
      ),
    );
    gh.factory<_i675.AppointmentRepository>(
      () => _i71.AppointmentRepositoryImpl(
        gh<_i41.AppointmentRemoteDataSource>(),
      ),
    );
    gh.factory<_i971.WorkingDaysRepository>(
      () => _i987.WorkingDaysRepositoryImpl(
        gh<_i369.WorkingDaysRemoteDataSource>(),
      ),
    );
    gh.factory<_i841.AddExpenseUseCase>(
      () => _i841.AddExpenseUseCase(gh<_i18.ExpenseRepository>()),
    );
    gh.factory<_i526.DeleteExpenseUseCase>(
      () => _i526.DeleteExpenseUseCase(gh<_i18.ExpenseRepository>()),
    );
    gh.factory<_i66.GetAllExpensesUseCase>(
      () => _i66.GetAllExpensesUseCase(gh<_i18.ExpenseRepository>()),
    );
    gh.factory<_i342.GetCategoriesUseCase>(
      () => _i342.GetCategoriesUseCase(gh<_i18.ExpenseRepository>()),
    );
    gh.factory<_i315.UpdateExpenseUseCase>(
      () => _i315.UpdateExpenseUseCase(gh<_i18.ExpenseRepository>()),
    );
    gh.factory<_i166.AddClinicUserUseCase>(
      () => _i166.AddClinicUserUseCase(gh<_i818.ClinicRepository>()),
    );
    gh.factory<_i398.GetClinicUsersUseCase>(
      () => _i398.GetClinicUsersUseCase(gh<_i818.ClinicRepository>()),
    );
    gh.factory<_i113.GetMyClinicsUseCase>(
      () => _i113.GetMyClinicsUseCase(gh<_i818.ClinicRepository>()),
    );
    gh.factory<_i860.GetReceivedInvitationsUseCase>(
      () => _i860.GetReceivedInvitationsUseCase(gh<_i818.ClinicRepository>()),
    );
    gh.factory<_i675.GetSentInvitationsUseCase>(
      () => _i675.GetSentInvitationsUseCase(gh<_i818.ClinicRepository>()),
    );
    gh.factory<_i223.RemoveClinicUserUseCase>(
      () => _i223.RemoveClinicUserUseCase(gh<_i818.ClinicRepository>()),
    );
    gh.factory<_i945.AcceptInvitationUseCase>(
      () => _i945.AcceptInvitationUseCase(gh<_i818.ClinicRepository>()),
    );
    gh.factory<_i945.DeclineInvitationUseCase>(
      () => _i945.DeclineInvitationUseCase(gh<_i818.ClinicRepository>()),
    );
    gh.factory<_i21.SendInvitationUseCase>(
      () => _i21.SendInvitationUseCase(gh<_i818.ClinicRepository>()),
    );
    gh.factory<_i972.UpdateUserRolesUseCase>(
      () => _i972.UpdateUserRolesUseCase(gh<_i818.ClinicRepository>()),
    );
    gh.factory<_i732.IssuesBloc>(
      () => _i732.IssuesBloc(
        getIssues: gh<_i239.GetIssuesUseCase>(),
        createIssue: gh<_i839.CreateIssueUseCase>(),
      ),
    );
    gh.factory<_i25.StatisticsDashboardBloc>(
      () =>
          _i25.StatisticsDashboardBloc(gh<_i850.StatisticsCatalogRepository>()),
    );
    gh.factory<_i779.GetPlansUseCase>(
      () => _i779.GetPlansUseCase(gh<_i900.SubscriptionRepository>()),
    );
    gh.factory<_i473.GetSubscriptionStatusUseCase>(
      () => _i473.GetSubscriptionStatusUseCase(
        gh<_i900.SubscriptionRepository>(),
      ),
    );
    gh.factory<_i989.GetSubscriptionUsageUseCase>(
      () =>
          _i989.GetSubscriptionUsageUseCase(gh<_i900.SubscriptionRepository>()),
    );
    gh.factory<_i127.GetClinicInfoUseCase>(
      () => _i127.GetClinicInfoUseCase(gh<_i1027.ClinicInfoRepository>()),
    );
    gh.factory<_i8.UpdateClinicInfoUseCase>(
      () => _i8.UpdateClinicInfoUseCase(gh<_i1027.ClinicInfoRepository>()),
    );
    gh.factory<_i594.AddPatientUseCase>(
      () => _i594.AddPatientUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i924.AddPaymentUseCase>(
      () => _i924.AddPaymentUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i208.AddTreatmentUseCase>(
      () => _i208.AddTreatmentUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i479.DetachPatientUseCase>(
      () => _i479.DetachPatientUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i931.GetAllCoreTreatmentsUseCase>(
      () => _i931.GetAllCoreTreatmentsUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i281.GetAllPatientsUseCase>(
      () => _i281.GetAllPatientsUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i126.GetAllTeethUseCase>(
      () => _i126.GetAllTeethUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i129.GetPatientCasesUseCase>(
      () => _i129.GetPatientCasesUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i1063.GetPatientDetailsUseCase>(
      () => _i1063.GetPatientDetailsUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i773.GetPaymentsUseCase>(
      () => _i773.GetPaymentsUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i920.MarkCaseAsFinishedUseCase>(
      () => _i920.MarkCaseAsFinishedUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i496.UpdatePatientUseCase>(
      () => _i496.UpdatePatientUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i526.WorkingDaysBloc>(
      () =>
          _i526.WorkingDaysBloc(repository: gh<_i971.WorkingDaysRepository>()),
    );
    gh.factory<_i506.ClinicInfoBloc>(
      () => _i506.ClinicInfoBloc(
        getClinicInfo: gh<_i127.GetClinicInfoUseCase>(),
        updateClinicInfo: gh<_i8.UpdateClinicInfoUseCase>(),
      ),
    );
    gh.factory<_i939.LogoutDeviceUseCase>(
      () => _i939.LogoutDeviceUseCase(gh<_i109.FcmTokenRepository>()),
    );
    gh.factory<_i928.RegisterFcmTokenUseCase>(
      () => _i928.RegisterFcmTokenUseCase(gh<_i109.FcmTokenRepository>()),
    );
    gh.factory<_i527.GetUserProfileUseCase>(
      () => _i527.GetUserProfileUseCase(gh<_i274.EditProfileRepository>()),
    );
    gh.factory<_i494.UpdateUserProfileUseCase>(
      () => _i494.UpdateUserProfileUseCase(gh<_i274.EditProfileRepository>()),
    );
    gh.factoryParam<_i475.ClinicUsersBloc, String, dynamic>(
      (clinicId, _) => _i475.ClinicUsersBloc(
        gh<_i398.GetClinicUsersUseCase>(),
        gh<_i166.AddClinicUserUseCase>(),
        gh<_i972.UpdateUserRolesUseCase>(),
        gh<_i223.RemoveClinicUserUseCase>(),
        clinicId,
      ),
    );
    gh.factory<_i833.PatientsListBloc>(
      () => _i833.PatientsListBloc(
        getAllPatients: gh<_i281.GetAllPatientsUseCase>(),
      ),
    );
    gh.factory<_i1011.SubscriptionBloc>(
      () => _i1011.SubscriptionBloc(
        getPlans: gh<_i779.GetPlansUseCase>(),
        guard: gh<_i821.SubscriptionGuard>(),
      ),
    );
    gh.factoryParam<_i13.UserHoursBloc, String, dynamic>(
      (userId, _) => _i13.UserHoursBloc(
        gh<_i971.WorkingDaysRepository>(),
        gh<_i663.UserStorage>(),
        userId: userId,
      ),
    );
    gh.factory<_i890.EditProfileBloc>(
      () => _i890.EditProfileBloc(
        getUserProfile: gh<_i527.GetUserProfileUseCase>(),
        updateUserProfile: gh<_i494.UpdateUserProfileUseCase>(),
        mediaService: gh<_i977.MediaService>(),
      ),
    );
    gh.factory<_i213.CreateAppointmentUseCase>(
      () => _i213.CreateAppointmentUseCase(gh<_i675.AppointmentRepository>()),
    );
    gh.factory<_i791.GetAllAppointmentsUseCase>(
      () => _i791.GetAllAppointmentsUseCase(gh<_i675.AppointmentRepository>()),
    );
    gh.factory<_i210.GetAvailableSlotsUseCase>(
      () => _i210.GetAvailableSlotsUseCase(gh<_i675.AppointmentRepository>()),
    );
    gh.factory<_i827.GetClinicDoctorsUseCase>(
      () => _i827.GetClinicDoctorsUseCase(gh<_i675.AppointmentRepository>()),
    );
    gh.factory<_i942.UpdateAppointmentStatusUseCase>(
      () => _i942.UpdateAppointmentStatusUseCase(
        gh<_i675.AppointmentRepository>(),
      ),
    );
    gh.factory<_i763.ExpenseBloc>(
      () => _i763.ExpenseBloc(
        getAllExpenses: gh<_i66.GetAllExpensesUseCase>(),
        addExpense: gh<_i841.AddExpenseUseCase>(),
        updateExpense: gh<_i315.UpdateExpenseUseCase>(),
        deleteExpense: gh<_i526.DeleteExpenseUseCase>(),
      ),
    );
    gh.factory<_i527.AddPatientBloc>(
      () => _i527.AddPatientBloc(addPatient: gh<_i594.AddPatientUseCase>()),
    );
    gh.factory<_i932.InvitationBloc>(
      () => _i932.InvitationBloc(
        gh<_i860.GetReceivedInvitationsUseCase>(),
        gh<_i675.GetSentInvitationsUseCase>(),
        gh<_i21.SendInvitationUseCase>(),
        gh<_i945.AcceptInvitationUseCase>(),
        gh<_i945.DeclineInvitationUseCase>(),
      ),
    );
    gh.factory<_i533.MyClinicsBloc>(
      () => _i533.MyClinicsBloc(
        gh<_i113.GetMyClinicsUseCase>(),
        gh<_i663.UserStorage>(),
      ),
    );
    gh.lazySingleton<_i40.NotificationService>(
      () => _i40.NotificationService(
        messaging: gh<_i892.FirebaseMessaging>(),
        localNotifications: gh<_i163.FlutterLocalNotificationsPlugin>(),
        registerFcmToken: gh<_i928.RegisterFcmTokenUseCase>(),
        logoutDevice: gh<_i939.LogoutDeviceUseCase>(),
        tokenStorage: gh<_i23.TokenStorage>(),
      ),
    );
    gh.factory<_i548.PatientDetailsBloc>(
      () => _i548.PatientDetailsBloc(
        getPatientDetails: gh<_i1063.GetPatientDetailsUseCase>(),
        markCaseAsFinished: gh<_i920.MarkCaseAsFinishedUseCase>(),
        addPayment: gh<_i924.AddPaymentUseCase>(),
      ),
    );
    gh.factory<_i154.AddTreatmentBloc>(
      () =>
          _i154.AddTreatmentBloc(addTreatment: gh<_i208.AddTreatmentUseCase>()),
    );
    gh.lazySingleton<_i614.NotificationPoller>(
      () => _i614.NotificationPoller(
        getUnseen: gh<_i453.GetUnseenNotificationsUseCase>(),
        markSeen: gh<_i219.MarkNotificationsSeenUseCase>(),
        notificationService: gh<_i40.NotificationService>(),
        tokenStorage: gh<_i23.TokenStorage>(),
      ),
    );
    gh.factory<_i675.AppointmentBloc>(
      () => _i675.AppointmentBloc(
        getAllAppointments: gh<_i791.GetAllAppointmentsUseCase>(),
        createAppointment: gh<_i213.CreateAppointmentUseCase>(),
        updateStatus: gh<_i942.UpdateAppointmentStatusUseCase>(),
      ),
    );
    gh.lazySingleton<_i103.UnreadCountCubit>(
      () => _i103.UnreadCountCubit(
        getUnreadCount: gh<_i874.GetUnreadCountUseCase>(),
        tokenStorage: gh<_i23.TokenStorage>(),
        notificationService: gh<_i40.NotificationService>(),
      ),
    );
    gh.lazySingleton<_i132.NotificationTopicsSynchronizer>(
      () => _i132.NotificationTopicsSynchronizer(
        getSettings: gh<_i275.GetNotificationSettingsUseCase>(),
        notificationService: gh<_i40.NotificationService>(),
        tokenStorage: gh<_i23.TokenStorage>(),
      ),
    );
    gh.lazySingleton<_i924.LanguageBloc>(
      () => blocInjection.languageBloc(
        gh<_i934.LanguageService>(),
        gh<_i962.ApiConsumer>(),
        gh<_i132.NotificationTopicsSynchronizer>(),
      ),
    );
    gh.factory<_i363.AuthBloc>(
      () => _i363.AuthBloc(
        gh<_i1015.AuthRepository>(),
        gh<_i23.TokenStorage>(),
        gh<_i663.UserStorage>(),
        gh<_i40.NotificationService>(),
        gh<_i132.NotificationTopicsSynchronizer>(),
        gh<_i614.NotificationPoller>(),
        gh<_i103.UnreadCountCubit>(),
      ),
    );
    gh.factory<_i493.NotificationSettingsBloc>(
      () => _i493.NotificationSettingsBloc(
        getSettings: gh<_i275.GetNotificationSettingsUseCase>(),
        updateSetting: gh<_i237.UpdateNotificationSettingUseCase>(),
        topics: gh<_i132.NotificationTopicsSynchronizer>(),
      ),
    );
    gh.factory<_i347.NotificationBloc>(
      () => _i347.NotificationBloc(
        getNotifications: gh<_i342.GetNotificationsUseCase>(),
        markAsRead: gh<_i818.MarkNotificationAsReadUseCase>(),
        markAsUnread: gh<_i519.MarkNotificationAsUnreadUseCase>(),
        markAllAsRead: gh<_i1060.MarkAllNotificationsAsReadUseCase>(),
        notificationService: gh<_i40.NotificationService>(),
        unreadCount: gh<_i103.UnreadCountCubit>(),
      ),
    );
    return this;
  }
}

class _$ThirdPartyInjection extends _i1007.ThirdPartyInjection {}

class _$BlocInjection extends _i732.BlocInjection {}
