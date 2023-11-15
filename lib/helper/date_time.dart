
import 'package:intl/intl.dart';

String currentDateTime(){
  return DateFormat.yMMMd().add_jm().format(DateTime.now());
}