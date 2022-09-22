import 'package:timer_group/domein/models/timer_group_options.dart';

int timeToInt(String first, String second, TimeFormat format) {
  if (format == TimeFormat.minuteSecond) {
    num result = (int.parse(first) * 60) + int.parse(second);
    return result.toInt();
  } else {
    num result = (int.parse(first) * 360) + (int.parse(second) * 60);
    return result.toInt();
  }
}
