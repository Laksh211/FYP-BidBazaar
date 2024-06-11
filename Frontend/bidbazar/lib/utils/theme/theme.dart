import 'package:flutter/material.dart';


class BidbazarTheme{
  BidbazarTheme._();//private constructor not in used

  static ThemeData lightTheme = ThemeData(





elevatedButtonTheme: ElevatedButtonThemeData(

          style: ButtonStyle(
              elevation: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return 5.0;
                } else {
                  return 3.0;
                }
              }),
              backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.white;
                } else {
                  return Colors.green;
                }
              }),
              shadowColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
              // textStyle: MaterialStateProperty.all(GoogleFonts.prompt(fontWeight: FontWeight.w600)),
              foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.green;
                } else {
                  return Colors.white;
                }
              }))),

    useMaterial3: true,
    brightness: Brightness.light,
     
    cardTheme: CardTheme(
      color:Colors.white

    ),
    
      colorScheme: ColorScheme.fromSeed(
seedColor: Colors.white, 
background: Colors.white, 
error: Colors.red, 
onTertiary: Colors.orange
),
    // colorScheme: ThemeData.light().colorScheme,
    // primaryColor: Colors.black,
    primarySwatch: Colors.amber,
    cardColor: Colors.white,
    textTheme:  TextTheme(
          // bodyMedium: ,
          bodyLarge: TextStyle(fontSize: 14,color:Colors.black87 ),
          bodyMedium: TextStyle().copyWith(fontSize: 14,color:Colors.black87),
          bodySmall: TextStyle().copyWith(fontSize: 12,color:Colors.black87),
          headlineLarge: TextStyle().copyWith(fontSize: 20,color:Colors.black87 , fontWeight:FontWeight.w500 ),
          headlineMedium: TextStyle().copyWith(fontSize: 18,color:Colors.black87),
          headlineSmall: TextStyle().copyWith(fontSize: 16,color:Colors.black87),
        
        ),

    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.orangeAccent[900],
        contentPadding: const EdgeInsets.all(10.0),
      
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 10.0,
        ),
        prefixIconColor: Colors.orangeAccent[900],
        iconColor: Colors.orangeAccent[900]
      
    ),
    scaffoldBackgroundColor: Colors.white,//background colors
    
    pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),

  );
  
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme:  TextTheme(
          bodyLarge: TextStyle(fontSize: 16,color:Colors.white),
          bodyMedium: TextStyle().copyWith(fontSize: 14,color:Colors.white),
          bodySmall: TextStyle().copyWith(fontSize: 12,color:Colors.white),
          headlineLarge: TextStyle().copyWith(fontSize: 20,color:Colors.white , fontWeight:FontWeight.w500 ),
          headlineMedium: TextStyle().copyWith(fontSize: 18,color:Colors.white),
          headlineSmall: TextStyle().copyWith(fontSize: 16,color:Colors.white),
     
        ),
    primaryColor: Colors.white,
    
    scaffoldBackgroundColor: Colors.black,
    pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
  );



}