import 'package:creiden/core/widgets/show_toast.dart';
import 'package:creiden/features/todo/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timezone/data/latest.dart' as tz;

import '/injection_container.dart' as di;
import 'features/auth/auth_injection.dart';
import 'features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/todo/note_injection.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  tz.initializeTimeZones();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 640));
    return MultiBlocProvider(
      providers: [
        ...authBlocs(context),
        ...noteBlocs(context),
      ],
      child: MaterialApp(
        title: 'Creiden TODO Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NotificationsHndler(),
      ),
    );
  }
}

class NotificationsHndler extends StatefulWidget {
  const NotificationsHndler({super.key});

  @override
  State<NotificationsHndler> createState() => _NotificationsHndlerState();
}

class _NotificationsHndlerState extends State<NotificationsHndler> {
  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('creiden_logo');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {},
    );
  }

  DateTime? currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutoLoginCubit, AutoLoginState>(
      listener: (context, state) {},
      builder: (context, autoLogin) {
        return WillPopScope(
          onWillPop: () {
            if (autoLogin is AutoLoginGuestModeState) {}
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime!) >
                    const Duration(seconds: 2)) {
              currentBackPressTime = now;
              showToast('click again to exit');
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: BlocBuilder<AutoLoginCubit, AutoLoginState>(
            builder: (context, state) {
              if (state is AutoLoginHasUser) {
                return const HomeScreen();
              } else if (state is AutoLoginNoUser) {
                return const LoginScreen();
              } else {
                return Scaffold(
                  body: Center(
                    child: Image.asset('assets/images/creiden_logo.png',
                        height: 150, width: 250, fit: BoxFit.fill),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
