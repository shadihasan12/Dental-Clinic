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

import 'core/api/api_consumer.dart' as _i962;
import 'core/api/dio_consumer.dart' as _i737;
import 'core/api/interceptors/error_interceptor.dart' as _i809;
import 'core/api/interceptors/logging_interceptor.dart' as _i416;
import 'core/di/third_party_injection.dart' as _i1007;
import 'core/network/network_info.dart' as _i75;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyInjection = _$ThirdPartyInjection();
    gh.singleton<_i361.Dio>(() => thirdPartyInjection.dio);
    gh.singleton<_i973.InternetConnectionChecker>(
      () => thirdPartyInjection.internetConnectionChecker,
    );
    gh.singleton<_i809.ErrorInterceptor>(() => _i809.ErrorInterceptor());
    gh.singleton<_i416.LoggingInterceptor>(() => _i416.LoggingInterceptor());
    gh.lazySingleton<_i75.NetworkInfo>(
      () => _i75.NetworkInfoImpl(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.singleton<_i962.ApiConsumer>(
      () => _i737.DioConsumer(
        gh<_i361.Dio>(),
        gh<_i809.ErrorInterceptor>(),
        gh<_i416.LoggingInterceptor>(),
      ),
    );
    return this;
  }
}

class _$ThirdPartyInjection extends _i1007.ThirdPartyInjection {}
