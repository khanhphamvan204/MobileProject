import 'package:intl/intl.dart';

class CurrencyFormatter {
  // Định dạng VND (ví dụ: 1.234.567 ₫)
  static String formatVND(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
      customPattern: '#,##0 \u00A4', // Đặt ký hiệu ₫ sau giá
    );
    return formatter.format(amount);
  }
}
