import 'package:timer_group/domein/models/timer_group_options.dart';

int timeToSecond(String duration) {
  int hours = int.parse(duration.substring(0, 2));
  int minutes = int.parse(duration.substring(3, 5));
  int seconds = int.parse(duration.substring(6, 8));

  num result = (hours * 3600) + (minutes * 60) + seconds;
  return result.toInt();
}

String intToTimeLeft(int value) {
  int h, m, s;
  h = value ~/ 3600;
  m = ((value - h * 3600)) ~/ 60;
  s = value - (h * 3600) - (m * 60);

  String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();
  String minuteLeft =
      m.toString().length < 2 ? "0" + m.toString() : m.toString();
  String secondsLeft =
      s.toString().length < 2 ? "0" + s.toString() : s.toString();
  String result = "$hourLeft:$minuteLeft:$secondsLeft";

  return result;
}

String secondToHour(int value) {
  double m = (value / 60.0);
  double h = m / 60.0;
  String result = '${h.toStringAsFixed(1)}時間';
  return result;
}

String secondToMinute(int value) {
  if(value < 60) {
    return "$value秒";
  } else {
    double m = value / 60.0;
    String result = "${double.parse(m.toStringAsFixed(1))}分";
    return result;
  }
}

String getFormattedTime(TimerGroupOptions options,int time) {
  if (options.timeFormat == TimeFormat.minuteSecond) {
    return secondToMinute(time);
  } else {
    return secondToHour(time);
  }
}
