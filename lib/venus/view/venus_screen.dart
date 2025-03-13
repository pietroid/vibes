import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VenusScreen extends StatefulWidget {
  const VenusScreen({super.key});

  @override
  State<VenusScreen> createState() => _VenusScreenState();
}

class _VenusScreenState extends State<VenusScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: totalTimeOfAnimationInSeconds),
    vsync: this,
  );
  late final AnimationController _roseController = AnimationController(
    duration: const Duration(seconds: finalIntervalInSeconds),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        const Duration(seconds: startIntervalInSeconds),
      );
      _controller.forward();
      await Future.delayed(
        const Duration(
            seconds: totalTimeOfAnimationInSeconds - finalIntervalInSeconds),
      );
      _roseController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, state) => CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width - 100,
                  MediaQuery.of(context).size.height - 100,
                ),
                painter: VenusPainter(
                  timeFraction: _controller.value,
                ),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              opacity: _roseController,
              'assets/icon/rose.png',
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

const venusToSunDistance = 67;
const earthToSunDistance = 93;
const totalTimeOfAnimationInSeconds = 15;
const startIntervalInSeconds = 2;
const int finalIntervalInSeconds = 1;

class VenusPainter extends CustomPainter {
  const VenusPainter({
    required this.timeFraction,
  });
  final double timeFraction;

  @override
  void paint(Canvas canvas, Size size) {
    final totalWidth = size.width;
    final totalHeight = size.height;

    final squaredSize = min(totalWidth, totalHeight);

    const padding = 20;

    final width = squaredSize - padding * 2;
    final height = squaredSize - padding * 2;

    final center = Offset(totalWidth / 2, totalHeight / 2);

    final totalRadius = squaredSize / 2;
    final theta = 2 * pi * timeFraction * 8;

    final sunRadius = totalRadius *
        earthToSunDistance /
        (earthToSunDistance + venusToSunDistance);

    final venusRadius = totalRadius *
        venusToSunDistance /
        (earthToSunDistance + venusToSunDistance);

    final earthCenter = Offset(totalWidth / 2, totalHeight / 2);

    final sunCenter = earthCenter +
        Offset(
          sunRadius * cos(theta),
          sunRadius * sin(theta),
        );

    final venusCenter = sunCenter +
        Offset(
          venusRadius * cos(13 / 8 * theta),
          venusRadius * sin(13 / 8 * theta),
        );
    final planetsAlpha = timeFraction > 0.9 ? (1 - timeFraction) / 0.1 : 1.0;

    final earthPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(88, 110, 255, 1).withOpacity(planetsAlpha);
    // draw the earth
    canvas.drawCircle(earthCenter, 15, earthPaint);

    final sunPaint = Paint()
      ..style = PaintingStyle.fill
      ..color =
          const Color.fromARGB(255, 252, 255, 105).withOpacity(planetsAlpha);
    //draw the sun
    canvas.drawCircle(sunCenter, 30, sunPaint);

    // draw orbit
    final orbitPaint = Paint()
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..color = const Color.fromARGB(255, 193, 16, 16);
    final orbitPath = Path();
    const thetaIncrement = 0.01;

    for (var i = 0; i <= (theta + 0.01) / thetaIncrement; i++) {
      final interpolatedTheta = i * thetaIncrement;
      final interpolatedSunCenter = earthCenter +
          Offset(
            sunRadius * cos(interpolatedTheta),
            sunRadius * sin(interpolatedTheta),
          );

      final interpolatedVenusCenter = interpolatedSunCenter +
          Offset(
            venusRadius * cos(13 / 8 * interpolatedTheta),
            venusRadius * sin(13 / 8 * interpolatedTheta),
          );

      if (i == 0) {
        orbitPath.moveTo(
          interpolatedVenusCenter.dx,
          interpolatedVenusCenter.dy,
        );
      } else {
        orbitPath.lineTo(
          interpolatedVenusCenter.dx,
          interpolatedVenusCenter.dy,
        );
      }
    }

    canvas.drawPath(orbitPath, orbitPaint);

    final venusPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withOpacity(planetsAlpha);

    // draw venus
    canvas.drawCircle(venusCenter, 12, venusPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
