import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

Color get getRandomColor => RandomColor().randomColor(
    colorBrightness: const ColorBrightness.custom(const Range(
        ((ColorBrightness.maxBrightness + ColorBrightness.minBrightness) ~/
            1.2),
        ColorBrightness.maxBrightness)));