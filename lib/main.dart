import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:web_app_template/business_logic/global_cubit/global_cubit.dart';
import 'package:web_app_template/business_logic/notifi_service.dart';
import 'package:web_app_template/data/local/cache_helper.dart';
import 'package:web_app_template/presentation/router/app_router.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_app_template/presentation/router/rout_names_dart.dart';
import 'package:web_app_template/presentation/styles/my_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  await CacheHelper.init();
  runApp(MyApp(appRouter: AppRouter()));
}

late Socket socket;
initSocket() {
  NotificationService().initNotification();
  String token =
      CacheHelper.getDataFromSharedPreference(key: 'token').replaceAll('"', '');
  socket = io.io(
      'https://api.halajary.ae?token=$token',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build());
  socket.connect();
  socket.onConnect((_) {
    debugPrint('---------------------Connection established');
  });
  socket.on("newNotification", (data) {
    debugPrint('---------------------New notifications');
    debugPrint('---------------------$data');
    NotificationService().showNotification(title: 'New Notification');
  });
  socket.on("newMessage", (data) {
    debugPrint('---------------------New Message');
    debugPrint('---------------------$data');
    NotificationService().showNotification(title: 'New Message');
  });
  socket.onDisconnect((_) {
    debugPrint('Connection Disconnected: $_');
    socket.connect();
  });
  socket.onConnectError((err) {
    debugPrint("onConnectError :$err");
    socket.connect();
  });
  socket.onError((err) => debugPrint("onError :$err"));
  debugPrint("${socket.io.options}");
}

class MyApp extends StatefulWidget {
  const MyApp({required this.appRouter, Key? key}) : super(key: key);
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    if (CacheHelper.getDataFromSharedPreference(key: 'token') != null) {
      initSocket();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => GlobalCubit())),
      ],
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return LayoutBuilder(builder: (context, constraints) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: widget.appRouter.onGenerateRoute,
                  initialRoute: RoutNamesDart.rSplashScreen,
                  theme: MyThemeData.lightTheme,
                  darkTheme: MyThemeData.darkTheme,
                );
              });
            },
          );
        },
      ),
    );
  }
}
