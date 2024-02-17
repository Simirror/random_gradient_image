import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class RandomGradientImage extends StatelessWidget {
  final String seed;
  final int maxColorNumber;
  final double maxHue;
  final double maxSaturation;
  final double maxLight;
  //final int maxAngle;
  const RandomGradientImage(
      {super.key,
      required this.seed,
      this.maxColorNumber = 2,
      this.maxHue = 270,
      this.maxSaturation = 0.5,
      this.maxLight = 0.5});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SvgPicture.string(
        generateSvgString(seed),
        fit: BoxFit.cover,
      ),
    );
  }

  String generateSvgString(String seed) {
    final Random random = Random(seed.hashCode);
    final int numOfColors = random.nextInt(maxColorNumber) + 2; // 随机2到5种颜色
    final List<Color> colors = List.generate(
      numOfColors,
      (_) => _generateRandomColor(random),
    );

    String svgString =
        '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">''';
    svgString +=
        '''<defs><linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="0%">''';

    for (int i = 0; i < numOfColors; i++) {
      final double offset = i / (numOfColors - 1) * 100;
      svgString +=
          '''<stop offset="$offset%" stop-color="${_colorToHex(colors[i])}" />''';
    }

    svgString += '''</linearGradient></defs>''';
    svgString +=
        '''<rect x="0" y="0" width="100" height="100" fill="url(#gradient)" /></svg>''';

    return svgString;
  }

  Color _generateRandomColor(Random random) {
    final double hue = random.nextDouble() * maxHue; // 随机色调
    final double saturation =
        random.nextDouble() * maxSaturation + 0.5; // 随机饱和度，范围为0.5到1
    final double value = random.nextDouble() * maxLight + 0.5; // 随机亮度，范围为0.5到1
    return HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}
