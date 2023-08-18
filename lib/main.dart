import 'package:flutter/material.dart';
import 'package:gymtesis/UI/video.dart';
import 'package:gymtesis/screens/home/home_tab.dart';
import 'package:gymtesis/screens/home/home_widget/check_auth_screen.dart';
import 'package:gymtesis/services/auth_service.dart';
import 'package:gymtesis/services/notifications_service.dart';
import 'package:gymtesis/services/plan_data.dart';

import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constanst.dart';
import 'screens/home/home_widget/video/video.dart';
import 'services/user_data.dart';
// import 'package:device_preview/device_preview.dart';

void main() async {
  
  runApp(
    //   DevicePreview(
    // enabled: true,
    // builder: (context) =>
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
          child: const StepperDemo(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsersData(),
          lazy: false,
        ),
        // ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => PlanData()),
      
      ],
      child: const MyApp(),
    ),
  // )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menssa',
         localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('es', 'ES'),
  ],
      theme: ThemeData(
        primaryColor: kSeconColor,
        primarySwatch: myColor,
        indicatorColor: kSeconColor,
        dialogBackgroundColor: kSeconColor,
        disabledColor: kPrimaryColor,
        dividerColor: Colors.white,
        focusColor: kPrimaryColor,
        highlightColor: kPrimaryColor,
        hintColor: kPrimaryColor,
        hoverColor: kPrimaryColor,
        primaryColorDark: kPrimaryColor,
        primaryColorLight: kPrimaryColor,
      ),
      initialRoute: "checking",
      routes: {
        
        'checking': (_) => const CheckAuthScreen(),

        "home": (_) => const HomeTab(),
        // "video":(_)=> CustomOrientationPlayer(),
        // "video": (_)=>  VideoApp()
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

MaterialColor myColor = const MaterialColor(
  0xFF0C2741, // Valor hexadecimal del color principal
  <int, Color>{
    50: Color(0xFFF2F5F9),
    100: Color.fromARGB(255, 109, 166, 223),
    200: Color(0xFFB6C4D4),
    300: Color(0xFF93A7BF),
    400: Color(0xFF7A94B1),
    500: Color(0xFF617FA3),
    600: Color(0xFF577595),
    700: Color(0xFF4D6B87),
    800: Color(0xFF435F79),
    900: Color(0xFF314B5E),
  },
);



