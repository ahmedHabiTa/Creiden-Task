import 'package:creiden/features/todo/presentation/cubit/get_all_notes/get_all_notes_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

sendNoteNotification({required BuildContext context}) {
  final notesList = context.read<GetAllNotesCubit>().noteList;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  for (int index = 0; index < notesList.length; index++) {
    final format = DateFormat('dd - MMMM - yyyy', 'en_US');
    final date = format.parse(notesList[index].date);
    final location = tz.getLocation('Africa/Cairo');
    final tzDate = tz.TZDateTime.from(date, location);
    String timeStr = notesList[index].time;
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
        notesList[index].id,
        'Remider for Upcomming Task',
        notesList[index].name,
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
