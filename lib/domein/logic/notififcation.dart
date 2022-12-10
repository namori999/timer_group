import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PlayableNotification {
  static final PlayableNotification _cache = PlayableNotification._();

  PlayableNotification._();

  factory PlayableNotification() {
    return _cache;
  }

  bool notificationIsActive(int? notificationStatus) => notificationStatus != 0;

  /// flutter_local_notificationsの初期化
  Future<void> initializeNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/app_icon');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  }

  /// タイムゾーンを定義
  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  /// セットしてある通知をキャンセル
  Future<void> cancelNotification() async {
    await FlutterLocalNotificationsPlugin().cancelAll();
  }

  ///通知をスケジュール
  Future<void> scheduleNotifications(
    DateTime dateTime,
    int timerIndex, {
    DateTimeComponents? dateTimeComponents,
  }) async {
    await configureLocalTimeZone();
    await cancelNotification();

    tz.TZDateTime playableDatetime = tz.TZDateTime(
      tz.local,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    );


    final localNotification = FlutterLocalNotificationsPlugin();
    await localNotification.zonedSchedule(
      0,
      '🐓 <[$timerIndex]つめのアラームが鳴っています',
      '',
      playableDatetime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'タイマー終了通知',
          '通知をONにしているとき、タイマー終了時にお知らせします',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: dateTimeComponents,
    );
  }
}
