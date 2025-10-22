class DateParser {

  //Parses a timestamp string from Supabase timestamptz into a DateTime.
  //Returns local time with handling if input is null or invalid.
  static DateTime parseToLocal(dynamic value, {DateTime? fallback}) {
    if (value == null) return fallback ?? DateTime.now();
    try {
      return DateTime.parse(value.toString()).toLocal();
    } catch (_) {
      return fallback ?? DateTime.now();
    }
  }
  
  //converts backt to timestamptz
  static String toUtcIso(DateTime date) => date.toUtc().toIso8601String();
}