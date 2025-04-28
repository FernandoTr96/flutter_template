
import 'package:intl/intl.dart';

class HumanFormatPlugin {

  static String formatNumber(double number, {String? locale, int decimalDigits = 2}) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern(locale ?? 'en_US')
    ..minimumFractionDigits = decimalDigits
    ..maximumFractionDigits = decimalDigits;
    return numberFormat.format(number);
  }

  static String formatCurrency(double amount, {String? locale, String currencySymbol = '\$'}) {
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: locale ?? 'en_US',
      symbol: currencySymbol,
    );
    return currencyFormat.format(amount);
  }

  static String formatDate(String date, {String? locale, String pattern = 'yMMMd'}) {
    final DateFormat dateFormat = DateFormat(pattern, locale ?? 'en_US');
    return dateFormat.format(DateTime.parse(date));
  }

  static String formatRelativeTime(DateTime date, {String? locale}) {
    final now = DateTime.now();
    final difference = now.difference(date);
    int yearDiff = now.year - date.year;
    int monthDiff = now.month - date.month + (yearDiff * 12);

    if (monthDiff > 6) {
      return DateFormat.yMMMMd(locale ?? 'en_US').format(date);
    } else if (monthDiff > 0) {
      return '$monthDiff months ago';
    } else if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }

  static String capitalize(String str) {
    return toBeginningOfSentenceCase(str) ?? '';
  }

  static String formatPercentage(double percentage, {int decimalDigits = 2, String? locale}) {
    final NumberFormat percentFormat = NumberFormat.percentPattern(locale ?? 'en_US')
      ..minimumFractionDigits = decimalDigits
      ..maximumFractionDigits = decimalDigits;
    return percentFormat.format(percentage);
  }

  static String formatTimeOfDay(DateTime time, {String? locale, String pattern = 'HH:mm'}) {
    final DateFormat timeFormat = DateFormat(pattern, locale ?? 'en_US');
    return timeFormat.format(time);
  }

  static String formatDuration(Duration duration, {String pattern = 'H:mm:ss'}) {
    final hours = duration.inHours;
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  static String formatPhoneNumber(String phoneNumber, {String locale = 'en_US'}) {
    final NumberFormat phoneFormat = NumberFormat.simpleCurrency(locale: locale);
    // Suponiendo que el formato depende del número de teléfono, puedes aplicar más lógica aquí.
    return phoneFormat.format(double.parse(phoneNumber)); 
  }
}
