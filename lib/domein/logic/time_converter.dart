
int timeToInt(String duration) {
    int hours = int.parse(duration.substring(0, 2));
    int minutes = int.parse(duration.substring(3, 5));
    int seconds = int.parse(duration.substring(6, 8));

    num result =(hours * 3600) + (minutes * 60) + seconds;
    return result.toInt();
}

/*
Future<int> totalTime(int id) async{
    timerRepository
    int
}
 */