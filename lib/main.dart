import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gyandarshan/core/colors.dart';
import 'package:gyandarshan/core/responsiveutils.dart';
import 'package:gyandarshan/presentation/screens/screen_loginpage/screen_loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light, // white icons
            statusBarBrightness: Brightness.dark, // iOS
          ),
        ),
        fontFamily: 'Helvetica',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Appcolors.kwhitecolor,
      ),
      home: ScreenLoginpage(),
    );
  }
}
