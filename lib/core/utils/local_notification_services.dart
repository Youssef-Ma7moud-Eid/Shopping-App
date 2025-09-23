import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LoalNotificationServices {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static onTap(NotificationResponse notificationResponse) {}
  static Future<void> initialize() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static void showBasicNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id_1",
        "Bacic Notification",
        importance:
            Importance.max, // make notifiction appear on top  and in app
        priority: Priority.high, // make notifiction appear on top  and in app
        playSound: true,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      1,
      "Payment Success",
      "Transaction Pyment Competet Success",
      details,
    );
  }

  static void showRepeatedNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id_2",
        "Repeated Notification",
        importance:
            Importance.max, // make notifiction appear on top  and in app
        priority: Priority.high, // make notifiction appear on top  and in app
        playSound: true,
      ),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      2,
      "Repeated  Notification",
      "My Repeated Notification",
      RepeatInterval.everyMinute,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // static void showScheduledNotification(int id, TaskModel task) async {
  //   NotificationDetails details = NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       task.id!,
  //       task.title ?? "No Title",
  //       importance:
  //           Importance.max, // make notifiction appear on top  and in app
  //       priority: Priority.high, // make notifiction appear on top  and in app
  //       playSound: true,
  //     ),
  //   );
  //   tz.initializeTimeZones();
  //   log('Current Timezone: ${tz.local.name}');
  //   final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  //   tz.setLocalLocation(tz.getLocation(currentTimeZone));
  //   log('Current Timezone: ${tz.local.name}');

  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     task.title,
  //     task.description,
  //     tz.TZDateTime(
  //       tz.local,
  //       task.dateTime!.year,
  //       task.dateTime!.month,
  //       task.dateTime!.day,
  //       task.dateTime!.hour,
  //       task.dateTime!.minute,
  //     ),
  //     details,
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //   );
  // }

  static Future<void> requestPermission() async {
    await Permission.notification.request();
  }

  static void cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
