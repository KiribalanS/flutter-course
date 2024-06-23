import 'package:expense_tracker/expense_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

ColorScheme kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 6, 161, 164),
);
ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 16, 69),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData().copyWith(
          scaffoldBackgroundColor: kDarkColorScheme.onPrimary,
          colorScheme: kDarkColorScheme,
          textTheme: TextTheme().copyWith(
              bodyMedium: TextStyle().copyWith(
            color: Colors.white,
          ))),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.onSecondaryContainer,
        ),
        scaffoldBackgroundColor: kColorScheme.onPrimaryContainer,
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.tertiaryContainer,
        ),
        cardColor: kColorScheme.onSecondaryContainer,
        listTileTheme: const ListTileThemeData().copyWith(
          tileColor: kColorScheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.onSecondary,
          ),
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: const TextStyle(
            fontSize: 21,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: const TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
      home: const ExpenseScreen(),
    );
  }
}
