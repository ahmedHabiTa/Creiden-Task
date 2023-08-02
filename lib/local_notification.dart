import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import 'features/todo/domain/entities/note_model.dart';

sendNoteNotification(
    {required BuildContext context, required List<NoteModel> noteList}) {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  for (int index = 0; index < noteList.length; index++) {
    final format = DateFormat('dd - MMMM - yyyy', 'en_US');
    final date = format.parse(noteList[index].date);
    final location = tz.getLocation('Africa/Cairo');
    final tzDate = tz.TZDateTime.from(date, location);
    String timeStr = noteList[index].time;
    DateTime dateTime = DateFormat('hh:mm a').parse(timeStr);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    final timeZone = tz.TZDateTime(
      location,
      tzDate.year,
      tzDate.month,
      tzDate.day,
      int.parse(formattedTime.split(':')[0]),
      int.parse(formattedTime.split(':')[1]),
      0,
    );
    if (tzDate.day == tz.TZDateTime.now(location).day) {
      flutterLocalNotificationsPlugin.zonedSchedule(
        noteList[index].id,
        'Remider for Upcomming Task',
        noteList[index].name,
        timeZone,
        const NotificationDetails(
            android: AndroidNotificationDetails('channel id', 'channel name',
                channelDescription: 'channel description')),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }
}
