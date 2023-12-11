import 'package:flutter/material.dart';

const styles = Styles();

class Styles {
  const Styles();

  Color get brandColor => Colors.deepPurple;
  Color get successColor => const Color(0xff00C851);

  ThemeData get mainTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: brandColor),
    useMaterial3: true,
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
    dividerTheme: const DividerThemeData(
      space: 1,
      indent: 0,
      endIndent: 0,
    ),
  );
}
