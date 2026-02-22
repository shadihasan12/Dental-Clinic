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
import 'core/api/interceptors/error_interceptor.dart' as _i809;
import 'core/api/interceptors/logging_interceptor.dart' as _i416;
import 'core/di/bloc_injection.dart' as _i732;
import 'core/di/third_party_injection.dart' as _i1007;
import 'core/localization/language_bloc.dart' as _i924;
import 'core/localization/language_service.dart' as _i934;
import 'core/network/network_info.dart' as _i75;
import 'features/patients/domain/use_cases/get_patient_cases_use_case.dart'
    as _i129;
import 'features/patients/domain/use_cases/get_patient_details_use_case.dart'
    as _i1063;
import 'features/patients/presentation/manager/patient_details_bloc.dart'
    as _i741;

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
    gh.factory<_i741.PatientDetailsBloc>(
      () => _i741.PatientDetailsBloc(
        getPatientDetails: gh<_i1063.GetPatientDetailsUseCase>(),
        getPatientCases: gh<_i129.GetPatientCasesUseCase>(),
      ),
    );
    gh.lazySingleton<_i75.NetworkInfo>(
      () => _i75.NetworkInfoImpl(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.lazySingleton<_i934.LanguageService>(
      () => blocInjection.languageService(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i962.ApiConsumer>(
      () => _i737.DioConsumer(
        gh<_i361.Dio>(),
        gh<_i809.ErrorInterceptor>(),
        gh<_i416.LoggingInterceptor>(),
      ),
    );
    gh.lazySingleton<_i924.LanguageBloc>(
      () => blocInjection.languageBloc(gh<_i934.LanguageService>()),
    );
    return this;
  }
}

class _$ThirdPartyInjection extends _i1007.ThirdPartyInjection {}

class _$BlocInjection extends _i732.BlocInjection {}
