import 'package:flutter/material.dart';

class AppLinearGradients {
  static const orange200 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xffFFE8B6),
      Color(0xffFFB9BE),
    ],
  );

  static const orange300 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xffFFD891),
      Color(0xffFF939B),
    ],
  );
  static const orange400 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xffFFCC70),
      Color(0xffFF6A75),
    ],
  );
  static const orangeDefault = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xffFFBC58),
      Color(0xffFF3A6A),
    ],
  );

  static const orange600 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xffFFB942),
      Color(0xffFF2656),
    ],
  );
  static const orange700 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xffCC8825),
      Color(0xffBD1739),
    ],
  );
  static const orange800 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xffB66906),
      Color(0xff970326),
    ],
  );

  static const orange900 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xff8E5F1E),
      Color(0xff7B0922),
    ],
  );
  static LinearGradient get orange075 => LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          const Color(0xffFFBC58).withOpacity(0.75),
          const Color(0xffFF3A6A).withOpacity(0.75),
        ],
      );
  static LinearGradient get orange050 => LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          const Color(0xffFFBC58).withOpacity(0.50),
          const Color(0xffFF3A6A).withOpacity(0.50),
        ],
      );
  static LinearGradient get orange025 => LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          const Color(0xffFFBC58).withOpacity(0.25),
          const Color(0xffFF3A6A).withOpacity(0.25),
        ],
      );
}
