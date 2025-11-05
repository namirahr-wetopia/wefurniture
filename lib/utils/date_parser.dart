class DateParser {
  static DateTime parseToLocal(dynamic value, {DateTime? fallback}) {
    if (value == null) return fallback ?? DateTime.now();
    try {
      return DateTime.parse(value.toString()).toLocal();
    } catch (_) {
      return fallback ?? DateTime.now();
    }
  }

  static String toUtcIso(DateTime date) => date.toUtc().toIso8601String();
}