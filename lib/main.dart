import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_remainder_thw/constants.dart';
import 'package:medicine_remainder_thw/pages/home_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Medicine Reminder',
        debugShowCheckedModeBanner: false,
        //theme customization
        theme: ThemeData.dark().copyWith(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kScaffoldColor,
          //app bar theme
          appBarTheme: AppBarTheme(
            toolbarHeight: 7.h,
            backgroundColor: kScaffoldColor,
            elevation: 0,
            iconTheme: IconThemeData(
              color: kSecondaryColor,
              size: 20.sp,
            ),
            titleTextStyle: GoogleFonts.mulish(
              color: kTextColor,
              fontWeight: FontWeight.w800,
              fontSize: 16.0.sp,
              fontStyle: FontStyle.normal,
            ),
          ),
          textTheme: TextTheme(
            headline3: TextStyle(
              fontSize: 28.0.sp,
              fontWeight: FontWeight.w500,
              color: kSecondaryColor,
            ),
            headline4: TextStyle(
              fontSize: 24.0.sp,
              fontWeight: FontWeight.w800,
              color: kTextColor,
            ),
            subtitle2: GoogleFonts.poppins(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
            caption: GoogleFonts.poppins(
              fontSize: 9.0.sp,
              fontWeight: FontWeight.w500,
              color: kPrimaryColor,
            ),
            labelMedium: TextStyle(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kTextLightColor,
                width: 0.7,
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kTextLightColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
        home: const HomePage(),
      );
    });
  }
}
