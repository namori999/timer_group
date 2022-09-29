
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
  int m;
  m = ((value - (value ~/ 3600) * 3600)) ~/ 60;

  double h = m / 60.0;
  String result = '${h.toStringAsFixed(1)}時間';
  return result;

}

String secondToMinute(int value) {

  double m = value / 60.0;
  String result = "$m分";
  return result;
}
