import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FinishNotification {
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

  ///通知をスケジュール
  Future<void> notify(
    int timerIndex, {
    DateTimeComponents? dateTimeComponents,
  }) async {
    final flnp = FlutterLocalNotificationsPlugin();
    return configureLocalTimeZone().then((_) => flnp.show(
          0,
          '🕊 <　${timerIndex+1}個めのアラームが鳴っています',
          null,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'channel_id',
              'タイマー終了通知',
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(
              presentSound: true,
            ),
          ),
        ));
  }
}
