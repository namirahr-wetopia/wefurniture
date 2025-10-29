import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String getBaseUrl() {
    final v = dotenv.env['SUPABASE_BASE_URL'];
    if (v == null || v.isEmpty) {
      throw Exception('SUPABASE_BASE_URL not found. Add it to .env');
    }
    return v;
  }

  static String getApiKey() {
    final v = dotenv.env['SUPABASE_ANON_KEY'];
    if (v == null || v.isEmpty) {
      throw Exception('SUPABASE_ANON_KEY not found. Add it to .env');
    }
    return v;
  }

  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'apikey': getApiKey(),
    'Authorization': 'Bearer  ${getApiKey()}',
  };
}