import 'package:intl/intl.dart';

class Utils {
  static String date(int qtd) {
    var hora = (qtd / 60);
    var horaDeterminada = 0;

    if (hora.toString().contains('5', 2)) {
      var str = hora.toString();
      horaDeterminada = int.parse(str[0]);
    } else if (hora.toString().contains('5', 3)) {
      var str = hora.toString();
      var time = (str[0] * 10) + (str[1]);
      horaDeterminada = int.parse(time);
    } else {
      horaDeterminada = int.parse((hora).toStringAsFixed(0));
    }
    var now = new DateTime.utc(
        0001, DateTime.now().month, 1, horaDeterminada, qtd % 60, 0);

    // var formatter = new DateFormat('kk:mm');
    var formatter = new DateFormat.Hm();
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
