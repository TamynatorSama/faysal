// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:faysal/app_navigator.dart';
import 'package:faysal/pages/auth/login/login.dart';
import 'package:faysal/pages/onboarding/onborading_main.dart';
import 'package:faysal/pages/rotating_savings/rotating_savings.dart';
import 'package:faysal/provider/all_proivders.dart';
import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/provider/history_provider.dart';
// import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/test_route_monitor.dart';
import 'package:faysal/utils/dynamic_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:quiver/async.dart';


const myTask = "fetchNotification";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    switch (taskName) {
      case myTask:
        HistoryProvider().fetchNotificationAndDisplay();
        break;
      case Workmanager.iOSBackgroundTask:
        break;
    }

    //Return true when the task executed successfully or not
    return Future.value(true);
  });

}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Workmanager().initialize(callbackDispatcher,);
  Workmanager().registerPeriodicTask("notification_task", myTask,
  constraints: Constraints(networkType: NetworkType.connected),
  frequency: const Duration(minutes: 16)
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);  


  await Login().initialize();
  AwesomeNotifications().initialize("", [
    NotificationChannel(
        channelKey: "notification_channel",
        channelName: "Basic Notifications",
        channelDescription:
            "Thsi notification channel is used to alert users of updates in the myfaysal app",
        defaultColor: const Color(0xff0A221C),
        importance: NotificationImportance.High,
        channelShowBadge: true
        )
  ]);
  await Firebase.initializeApp();
  DynamicLinkHandler().initializeDynamicLink();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final List<AppLifecycleState> _stateHistoryList = <AppLifecycleState>[];
  final lastKnownStateKey = 'lastKnownStateKey';

  @override
  void initState() {
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addObserver(this);
    if (WidgetsBinding.instance.lifecycleState != null) {
      // print(WidgetsBinding.instance.lifecycleState!);
      _stateHistoryList.add(WidgetsBinding.instance.lifecycleState!);
    }
    FlutterNativeSplash.remove();
    super.initState();
  }
  CountdownTimer? _timer;
  

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.resumed:
        if(_timer!.remaining > const Duration(seconds: 0)){
          
        }
        else{
          handleEntryPin(state);
        }
        _timer!.cancel();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:

         _timer ??= CountdownTimer(const Duration(seconds: 50), const Duration(seconds: 1));
        // _paused();
        break;
      // case AppLifecycleState.inactive:
      //   _inactive();
      //   break;
      default:
        break;
    }
    // handleEntryPin(state);
    
  }

  void handleEntryPin(AppLifecycleState state)async{
      if (state.name == "resumed") {
      ButtomNavBarProvider().hasScreenResumed = true;
    } else {
      ButtomNavBarProvider().hasScreenResumed = false;
    }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Faysal',
          navigatorKey: MyApp.navigationKey,
          // initialRoute: "/home",
          routes: {
            '/home': (context) => const AppNavigator(),
            '/ajo': (context) => const RotatingSavings(),
            // '/second': (context) => const secondRoute(),
          },
          theme: ThemeData(brightness: Brightness.light),
          home: 
          Login().loggedIn != true
              ? Login().firstTimeUsage != true
                  ? const OnBoardingMain()
                  : const LoginWidget()
              : const LoginWidget()),
    );
  }
}
