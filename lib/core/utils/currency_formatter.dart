import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _usd = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  static final _compact = NumberFormat.compactCurrency(locale: 'en_US', symbol: '\$');

  static String format(num? value, {bool compact = false}) {
    if (value == null) return '—';
    return compact ? _compact.format(value) : _usd.format(value);
  }

  static String formatDelta(num? value) {
    if (value == null) return '—';
    final prefix = value >= 0 ? '+' : '';
    return '$prefix${_usd.format(value)}';
  }
}
