// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
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
import 'core/storage/token_storage.dart' as _i23;
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
import 'features/appointments/presentation/manager/appointment_bloc.dart'
    as _i675;
import 'features/auth/data/datasources/remote/auth_remote_data_source.dart'
    as _i689;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
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
import 'features/expenses/presentation/manager/expense_bloc.dart' as _i763;
import 'features/home/data/data_sources/notification_remote_data_source.dart'
    as _i573;
import 'features/home/data/repositories/notification_repository_impl.dart'
    as _i20;
import 'features/home/domain/repositories/notification_repository.dart' as _i4;
import 'features/home/domain/use_cases/get_all_notifications_use_case.dart'
    as _i923;
import 'features/home/domain/use_cases/mark_all_notifications_as_read_use_case.dart'
    as _i1060;
import 'features/home/domain/use_cases/mark_notification_as_read_use_case.dart'
    as _i818;
import 'features/home/presentation/manager/notification_bloc.dart' as _i347;
import 'features/patients/data/data_sources/patient_remote_data_source.dart'
    as _i536;
import 'features/patients/data/repositories/patient_repository_impl.dart'
    as _i504;
import 'features/patients/domain/repositories/patient_repository.dart' as _i192;
import 'features/patients/domain/use_cases/add_patient_use_case.dart' as _i594;
import 'features/patients/domain/use_cases/add_treatment_use_case.dart'
    as _i208;
import 'features/patients/domain/use_cases/get_all_patients_use_case.dart'
    as _i281;
import 'features/patients/domain/use_cases/get_patient_cases_use_case.dart'
    as _i129;
import 'features/patients/domain/use_cases/get_patient_details_use_case.dart'
    as _i1063;
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
import 'features/profile/presentation/pages/clinic_info/data/repositories/clinic_info_repository_impl.dart'
    as _i841;
import 'features/profile/presentation/pages/clinic_info/domain/repositories/clinic_info_repository.dart'
    as _i1027;
import 'features/profile/presentation/pages/clinic_info/domain/use_cases/get_clinic_info_use_case.dart'
    as _i127;
import 'features/profile/presentation/pages/clinic_info/domain/use_cases/update_clinic_info_use_case.dart'
    as _i8;
import 'features/profile/presentation/pages/clinic_info/presentation/manager/clinic_info_bloc.dart'
    as _i506;
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
import 'features/profile/presentation/pages/support/data/data_sources/support_remote_data_source.dart'
    as _i348;
import 'features/profile/presentation/pages/support/data/repositories/support_repository_impl.dart'
    as _i754;
import 'features/profile/presentation/pages/support/domain/repositories/support_repository.dart'
    as _i778;
import 'features/profile/presentation/pages/support/domain/use_cases/create_conversation_use_case.dart'
    as _i134;
import 'features/profile/presentation/pages/support/domain/use_cases/get_auto_reply_use_case.dart'
    as _i498;
import 'features/profile/presentation/pages/support/domain/use_cases/get_conversations_use_case.dart'
    as _i983;
import 'features/profile/presentation/pages/support/domain/use_cases/send_message_use_case.dart'
    as _i166;
import 'features/profile/presentation/pages/support/presentation/manager/support_chat_bloc.dart'
    as _i766;
import 'features/profile/presentation/pages/support/presentation/manager/support_conversations_bloc.dart'
    as _i45;
import 'features/subscription/data/data_sources/subscription_remote_data_source.dart'
    as _i151;
import 'features/subscription/data/repositories/subscription_repository_impl.dart'
    as _i155;
import 'features/subscription/domain/repositories/subscription_repository.dart'
    as _i900;
import 'features/subscription/domain/use_cases/get_plans_use_case.dart'
    as _i779;
import 'features/subscription/presentation/bloc/subscription_bloc.dart'
    as _i1011;

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
    gh.factory<_i23.TokenStorage>(
      () => _i23.TokenStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i75.NetworkInfo>(
      () => _i75.NetworkInfoImpl(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.singleton<_i240.AuthInterceptor>(
      () => _i240.AuthInterceptor(gh<_i23.TokenStorage>()),
    );
    gh.lazySingleton<_i934.LanguageService>(
      () => blocInjection.languageService(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i962.ApiConsumer>(
      () => _i737.DioConsumer(
        gh<_i361.Dio>(),
        gh<_i240.AuthInterceptor>(),
        gh<_i809.ErrorInterceptor>(),
        gh<_i416.LoggingInterceptor>(),
      ),
    );
    gh.factory<_i689.AuthRemoteDataSource>(
      () => _i689.AuthRemoteDataSourceImpl(
        gh<_i962.ApiConsumer>(),
        gh<_i23.TokenStorage>(),
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
    gh.lazySingleton<_i924.LanguageBloc>(
      () => blocInjection.languageBloc(gh<_i934.LanguageService>()),
    );
    gh.factory<_i355.ExpenseRemoteDataSource>(
      () => _i355.ExpenseRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.lazySingleton<_i536.PatientRemoteDataSource>(
      () => _i536.PatientRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i485.ClinicInfoRemoteDataSource>(
      () => _i485.ClinicInfoRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i455.NotificationSettingsRepository>(
      () => _i395.NotificationSettingsRepositoryImpl(
        gh<_i806.NotificationSettingsRemoteDataSource>(),
      ),
    );
    gh.factory<_i151.SubscriptionRemoteDataSource>(
      () => _i151.SubscriptionRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i348.SupportRemoteDataSource>(
      () => _i348.SupportRemoteDataSourceImpl(gh<_i962.ApiConsumer>()),
    );
    gh.factory<_i275.GetNotificationSettingsUseCase>(
      () => _i275.GetNotificationSettingsUseCase(
        gh<_i455.NotificationSettingsRepository>(),
      ),
    );
    gh.factory<_i237.UpdateNotificationSettingsUseCase>(
      () => _i237.UpdateNotificationSettingsUseCase(
        gh<_i455.NotificationSettingsRepository>(),
      ),
    );
    gh.factory<_i4.NotificationRepository>(
      () => _i20.NotificationRepositoryImpl(
        gh<_i573.NotificationRemoteDataSource>(),
      ),
    );
    gh.factory<_i493.NotificationSettingsBloc>(
      () => _i493.NotificationSettingsBloc(
        getSettings: gh<_i275.GetNotificationSettingsUseCase>(),
        updateSettings: gh<_i237.UpdateNotificationSettingsUseCase>(),
      ),
    );
    gh.factory<_i900.SubscriptionRepository>(
      () => _i155.SubscriptionRepositoryImpl(
        gh<_i151.SubscriptionRemoteDataSource>(),
      ),
    );
    gh.factory<_i192.PatientRepository>(
      () => _i504.PatientRepositoryImpl(gh<_i536.PatientRemoteDataSource>()),
    );
    gh.factory<_i923.GetAllNotificationsUseCase>(
      () => _i923.GetAllNotificationsUseCase(gh<_i4.NotificationRepository>()),
    );
    gh.factory<_i1060.MarkAllNotificationsAsReadUseCase>(
      () => _i1060.MarkAllNotificationsAsReadUseCase(
        gh<_i4.NotificationRepository>(),
      ),
    );
    gh.factory<_i818.MarkNotificationAsReadUseCase>(
      () =>
          _i818.MarkNotificationAsReadUseCase(gh<_i4.NotificationRepository>()),
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
    gh.factory<_i841.AddExpenseUseCase>(
      () => _i841.AddExpenseUseCase(gh<_i18.ExpenseRepository>()),
    );
    gh.factory<_i526.DeleteExpenseUseCase>(
      () => _i526.DeleteExpenseUseCase(gh<_i18.ExpenseRepository>()),
    );
    gh.factory<_i66.GetAllExpensesUseCase>(
      () => _i66.GetAllExpensesUseCase(gh<_i18.ExpenseRepository>()),
    );
    gh.factory<_i779.GetPlansUseCase>(
      () => _i779.GetPlansUseCase(gh<_i900.SubscriptionRepository>()),
    );
    gh.factory<_i778.SupportRepository>(
      () => _i754.SupportRepositoryImpl(gh<_i348.SupportRemoteDataSource>()),
    );
    gh.factory<_i127.GetClinicInfoUseCase>(
      () => _i127.GetClinicInfoUseCase(gh<_i1027.ClinicInfoRepository>()),
    );
    gh.factory<_i8.UpdateClinicInfoUseCase>(
      () => _i8.UpdateClinicInfoUseCase(gh<_i1027.ClinicInfoRepository>()),
    );
    gh.factory<_i129.GetPatientCasesUseCase>(
      () => _i129.GetPatientCasesUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i1063.GetPatientDetailsUseCase>(
      () => _i1063.GetPatientDetailsUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i281.GetAllPatientsUseCase>(
      () => _i281.GetAllPatientsUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i594.AddPatientUseCase>(
      () => _i594.AddPatientUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i208.AddTreatmentUseCase>(
      () => _i208.AddTreatmentUseCase(gh<_i192.PatientRepository>()),
    );
    gh.factory<_i506.ClinicInfoBloc>(
      () => _i506.ClinicInfoBloc(
        getClinicInfo: gh<_i127.GetClinicInfoUseCase>(),
        updateClinicInfo: gh<_i8.UpdateClinicInfoUseCase>(),
      ),
    );
    gh.factory<_i347.NotificationBloc>(
      () => _i347.NotificationBloc(
        getAllNotifications: gh<_i923.GetAllNotificationsUseCase>(),
        markNotificationAsRead: gh<_i818.MarkNotificationAsReadUseCase>(),
        markAllNotificationsAsRead:
            gh<_i1060.MarkAllNotificationsAsReadUseCase>(),
      ),
    );
    gh.factory<_i527.GetUserProfileUseCase>(
      () => _i527.GetUserProfileUseCase(gh<_i274.EditProfileRepository>()),
    );
    gh.factory<_i494.UpdateUserProfileUseCase>(
      () => _i494.UpdateUserProfileUseCase(gh<_i274.EditProfileRepository>()),
    );
    gh.factory<_i1011.SubscriptionBloc>(
      () => _i1011.SubscriptionBloc(getPlans: gh<_i779.GetPlansUseCase>()),
    );
    gh.factory<_i833.PatientsListBloc>(
      () => _i833.PatientsListBloc(
        getAllPatients: gh<_i281.GetAllPatientsUseCase>(),
      ),
    );
    gh.factory<_i763.ExpenseBloc>(
      () => _i763.ExpenseBloc(
        getAllExpenses: gh<_i66.GetAllExpensesUseCase>(),
        addExpense: gh<_i841.AddExpenseUseCase>(),
        deleteExpense: gh<_i526.DeleteExpenseUseCase>(),
      ),
    );
    gh.factory<_i134.CreateConversationUseCase>(
      () => _i134.CreateConversationUseCase(gh<_i778.SupportRepository>()),
    );
    gh.factory<_i498.GetAutoReplyUseCase>(
      () => _i498.GetAutoReplyUseCase(gh<_i778.SupportRepository>()),
    );
    gh.factory<_i983.GetConversationsUseCase>(
      () => _i983.GetConversationsUseCase(gh<_i778.SupportRepository>()),
    );
    gh.factory<_i166.SendMessageUseCase>(
      () => _i166.SendMessageUseCase(gh<_i778.SupportRepository>()),
    );
    gh.factory<_i213.CreateAppointmentUseCase>(
      () => _i213.CreateAppointmentUseCase(gh<_i675.AppointmentRepository>()),
    );
    gh.factory<_i791.GetAllAppointmentsUseCase>(
      () => _i791.GetAllAppointmentsUseCase(gh<_i675.AppointmentRepository>()),
    );
    gh.factory<_i527.AddPatientBloc>(
      () => _i527.AddPatientBloc(addPatient: gh<_i594.AddPatientUseCase>()),
    );
    gh.factory<_i766.SupportChatBloc>(
      () => _i766.SupportChatBloc(
        sendMessage: gh<_i166.SendMessageUseCase>(),
        getAutoReply: gh<_i498.GetAutoReplyUseCase>(),
      ),
    );
    gh.factory<_i548.PatientDetailsBloc>(
      () => _i548.PatientDetailsBloc(
        getPatientDetails: gh<_i1063.GetPatientDetailsUseCase>(),
        getPatientCases: gh<_i129.GetPatientCasesUseCase>(),
      ),
    );
    gh.factory<_i154.AddTreatmentBloc>(
      () =>
          _i154.AddTreatmentBloc(addTreatment: gh<_i208.AddTreatmentUseCase>()),
    );
    gh.factory<_i890.EditProfileBloc>(
      () => _i890.EditProfileBloc(
        getUserProfile: gh<_i527.GetUserProfileUseCase>(),
        updateUserProfile: gh<_i494.UpdateUserProfileUseCase>(),
      ),
    );
    gh.factory<_i45.SupportConversationsBloc>(
      () => _i45.SupportConversationsBloc(
        getConversations: gh<_i983.GetConversationsUseCase>(),
        createConversation: gh<_i134.CreateConversationUseCase>(),
      ),
    );
    gh.factory<_i675.AppointmentBloc>(
      () => _i675.AppointmentBloc(
        getAllAppointments: gh<_i791.GetAllAppointmentsUseCase>(),
        createAppointment: gh<_i213.CreateAppointmentUseCase>(),
      ),
    );
    return this;
  }
}

class _$ThirdPartyInjection extends _i1007.ThirdPartyInjection {}

class _$BlocInjection extends _i732.BlocInjection {}
