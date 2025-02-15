import 'dart:math';

import 'package:flutter/widgets.dart';

class OscillatingBuilder extends StatefulWidget {
  const OscillatingBuilder({
    required this.minValue,
    required this.maxValue,
    required this.builder,
    this.staticChild,
    super.key,
    this.period = 1.0,
    this.phase = 0.0,
  });

  /// period in seconds of the oscillation
  final double period;

  /// phase of the wave in percentage of the period
  final double phase;

  /// maxValue of the wave
  final double minValue;

  /// minValue of the wave
  final double maxValue;

  final Widget Function(
    BuildContext context,
    double signal,
    Widget? staticChild,
  ) builder;

  final Widget? staticChild;

  @override
  State<OscillatingBuilder> createState() => _OscillatingBuilderState();
}

class _OscillatingBuilderState extends State<OscillatingBuilder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: (widget.period * 1000).toInt()),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final source = sin(
          2 * pi * _controller.value + widget.phase * 2 * pi,
        );
        final signalNormalized = (source + 1) / 2;
        final signalRange = widget.maxValue - widget.minValue;
        final signalValue = widget.minValue + signalNormalized * signalRange;
        return widget.builder(context, signalValue, child);
      },
      child: widget.staticChild,
    );
  }
}
