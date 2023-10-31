import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initNotification() async {
    if (!_initialized) {
      tz.initializeTimeZones();

      AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('flutter_logo');

      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: null, // Configurações do iOS são nulas (não usadas para Android).
      );

      // Solicita permissões para Android.
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();


      await notificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse:
              (NotificationResponse notificationResponse) async {});

      _initialized = true;
    }
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max),
      iOS: null, // Configurações do iOS são nulas (não usadas para Android).
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    await initNotification(); // Garante que as notificações estão inicializadas.
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {required int id,
        String? title,
        String? body,
        String? payload,
        required DateTime scheduledNotificationDateTime}) async {
    await initNotification(); // Garante que as notificações estão inicializadas.
    // return await notificationsPlugin.zonedSchedule(
    //   id,
    //   title,
    //   body,
    //   tz.TZDateTime.from(
    //     scheduledNotificationDateTime,
    //     tz.local,
    //   ),
    //   notificationDetails(),
    //   androidAllowWhileIdle: true,
    //   matchDateTimeComponents: DateTimeComponents.time,
    //   uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    // );

    tz.initializeTimeZones();
    // var scheduledDate = tz.TZDateTime.now(tz.local).add(
    //   Duration(seconds: 2
    //     // days: 1,
    //     // hours: 1,
    //     // minutes: 1,
    //   ),
    // );

    // var scheduledDate = tz.TZDateTime(
    //   tz.local,
    //   scheduledNotificationDateTime.year,
    //   scheduledNotificationDateTime.month,
    //   scheduledNotificationDateTime.day,
    //   scheduledNotificationDateTime.hour,
    //   scheduledNotificationDateTime.minute,
    //   scheduledNotificationDateTime.second,
    // );
    Duration offsetTime= DateTime.now().timeZoneOffset;

    tz.TZDateTime zonedTime = tz.TZDateTime.local(
      scheduledNotificationDateTime.year,
      scheduledNotificationDateTime.month,
      scheduledNotificationDateTime.day,
      scheduledNotificationDateTime.hour,
      scheduledNotificationDateTime.minute,
      scheduledNotificationDateTime.second,
    ).subtract(offsetTime);

    print("DATA>>>>>>>>>>>>> $zonedTime");

    return await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      zonedTime,
      notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );


  }
}
