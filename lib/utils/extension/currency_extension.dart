import 'package:intl/intl.dart';

extension StringExtension on String? {
  String? toCurrencyFormat({var format = '\$'}) {
    return format + this;
  }

  String formatDateTime() {
    if (this == null || this!.isEmpty || this == "null") {
      return "NA";
    } else {
      return DateFormat("HH:mm dd MMM yyyy", "en_US").format(DateFormat("yyyy-MM-dd HH:mm:ss.0", "en_US").parse(this!));
    }
  }

  String formatDate() {
    if (this == null || this!.isEmpty || this == "null") {
      return "NA";
    } else {
      return DateFormat("dd MMM yyyy", "en_US").format(DateFormat("yyyy-MM-dd", "en_US").parse(this!));
    }
  }
}