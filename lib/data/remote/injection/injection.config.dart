// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i409;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;
import 'package:we_furniture/data/remote/injection/injection.dart' as _i976;
import 'package:we_furniture/data/remote/services/auth_service.dart' as _i845;
import 'package:we_furniture/view/profile_screen/profile.dart' as _i254;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.factory<_i845.AuthService>(
      () => _i845.AuthService(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i254.ProfileScreen>(
      () => _i254.ProfileScreen(
        key: gh<_i409.Key>(),
        authService: gh<_i845.AuthService>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i976.RegisterModule {}
