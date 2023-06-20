import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_remainder_thw/constants.dart';
import 'package:medicine_remainder_thw/pages/home_screen.dart';
import 'package:medicine_remainder_thw/pages/new_entry/new_entry_block.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  NewEntryBlock? newEntryBlock;

  @override
  void initState() {
    newEntryBlock = NewEntryBlock();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<NewEntryBlock>.value(
      value: newEntryBlock!,
      child: Sizer(builder: (context, orientation, deviceType) {
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
              headline6: GoogleFonts.poppins(
                  fontSize: 13.0.sp,
                  fontWeight: FontWeight.w600,
                  color: kTextColor,
                  letterSpacing: 1.0),
              subtitle2: GoogleFonts.poppins(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w500,
                color: kTextColor,
              ),
              caption: GoogleFonts.poppins(
                fontSize: 9.0.sp,
                fontWeight: FontWeight.w500,
                color: kTextLightColor,
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
            //customize time picker theme
            timePickerTheme: TimePickerThemeData(
              backgroundColor: kScaffoldColor,
              hourMinuteColor: kTextColor,
              hourMinuteTextColor: kScaffoldColor,
              dayPeriodColor: kTextColor,
              dayPeriodTextColor: kScaffoldColor,
              dialBackgroundColor: kTextColor,
              dialHandColor: kPrimaryColor,
              dialTextColor: kScaffoldColor,
              entryModeIconColor: kOtherColor,
              dayPeriodTextStyle: GoogleFonts.aBeeZee(
                fontSize: 9.0.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          home: const HomePage(),
        );
      }),
    );
  }
}
