import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const styles = Styles();

class Styles {
  const Styles();

  Color get brandColor => Colors.deepPurple;

  Color get brandColorLight => Colors.deepPurple.shade50;

  Color get successColor => const Color(0xff00C851);

  Color get dangerColor => const Color(0xffff4444);

  ThemeData get mainTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: brandColor),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: brandColorLight,
          foregroundColor: Colors.black,
          titleTextStyle: const TextStyle(fontSize: 18, color: Colors.black),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 70,
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return TextStyle(color: brandColor, fontSize: 12);
            }
            return const TextStyle(fontSize: 12);
          }),
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: brandColor);
            }
            return null;
          }),
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
        dividerTheme: const DividerThemeData(
          space: 1,
          indent: 0,
          endIndent: 0,
        ),
      );
}
