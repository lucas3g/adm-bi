import 'dart:math';

import 'package:flutter/material.dart';

abstract class AppGradients {
  Gradient get background;
  Gradient get gradientColorsLineGrid;
  Gradient get gradientColorsGridWithOpacity;
}

class AppGradientsDefault implements AppGradients {
  @override
  Gradient get background => const LinearGradient(
        colors: [
          Color(0xFFEB5757),
          Color(0xFFFF0000),
        ],
        transform: GradientRotation(2.35619 * pi),
      );

  @override
  Gradient get gradientColorsGridWithOpacity => LinearGradient(colors: [
        const Color(0xFF23B6E6).withOpacity(0.3),
        const Color(0xFF02D39A).withOpacity(0.3)
      ]);

  @override
  Gradient get gradientColorsLineGrid =>
      const LinearGradient(colors: [Color(0xFF23B6E6), Color(0xFF02D39A)]);
}
