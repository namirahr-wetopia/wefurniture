import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_furniture/data/remote/injection/injection.config.dart';
import '../services/auth_service.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async =>  getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  SupabaseClient get supabaseClient => Supabase.instance.client;
}