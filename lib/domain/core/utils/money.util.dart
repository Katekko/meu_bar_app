import 'package:money2/money2.dart';

class MoneyUtil {
  static String formatBRL(double value) {
    final money = Money.fromNum(value, code: 'BRL');
    return money.format('S ##.###,00');
  }

  static double removeMaskBRL(String value) {
    final onlyNumber = value.replaceAll(RegExp('[^0-9]'), '');
    final finalValue = double.parse(onlyNumber) / 100;
    return finalValue;
  }
}
