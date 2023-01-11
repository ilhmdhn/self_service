import 'package:intl/intl.dart';

class Currency {
  static String toRupiah(num? nominal) {
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0);
    return currencyFormatter.format(nominal);
  }
}
