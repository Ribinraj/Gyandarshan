import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyandarshan/core/colors.dart';
import 'package:gyandarshan/core/responsiveutils.dart';
import 'package:gyandarshan/domain/repositories/apprepo.dart';
import 'package:gyandarshan/presentation/bloc/fetch_category_bloc/fetch_category_bloc.dart';
import 'package:gyandarshan/presentation/bloc/fetch_content_bloc/fetch_content_bloc.dart';
import 'package:gyandarshan/presentation/bloc/fetch_division_bloc/fetch_division_bloc.dart';
import 'package:gyandarshan/presentation/bloc/fetch_subcategory_bloc/fetch_subcategory_bloc.dart';
import 'package:gyandarshan/presentation/bloc/login_bloc/login_bloc.dart';


import 'package:gyandarshan/presentation/screens/screen_splashpage/screen_splashpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchDivisionBloc(repository: Apprepo()),
        ),
        BlocProvider(create: (context) =>LoginBloc(repository:Apprepo())),
         BlocProvider(create: (context) =>FetchCategoryBloc(repository:Apprepo())),
          BlocProvider(create: (context) =>FetchSubcategoryBloc(repository:Apprepo())),
          BlocProvider(create: (context) =>FetchContentBloc(repository:Apprepo())),
      ],
      child: MaterialApp(
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
        home:SplashPage(),
      ),
    );
  }
}
