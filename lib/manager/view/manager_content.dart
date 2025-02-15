import 'dart:math';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:vibes/elements/oscillating_builder.dart';

class ManagerContent extends StatelessWidget {
  const ManagerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 4,
        childAspectRatio: 0.5,
        children: [
          FeatureButton(
            content: const Icon(
              Icons.sentiment_satisfied_alt_rounded,
              size: 32,
            ),
            label: 'Mood',
            onTap: () {},
          ),
          FeatureButton(
            content: const Icon(
              Icons.spa,
              size: 32,
            ),
            label: 'Relax',
            onTap: () {},
          ),
          FeatureButton(
            content: const Icon(
              Icons.schedule,
              size: 32,
            ),
            label: 'Clock',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class FeatureButton extends StatefulWidget {
  const FeatureButton({
    required this.content,
    required this.label,
    required this.onTap,
    super.key,
  });
  final Widget content;
  final String label;
  final VoidCallback onTap;

  @override
  State<FeatureButton> createState() => _FeatureButtonState();
}

class _FeatureButtonState extends State<FeatureButton> {
  late final period = (Random().nextDouble() + 1) * 4;
  late final phase = Random().nextDouble();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: OscillatingBuilder(
              minValue: 0,
              maxValue: 1,
              period: period,
              phase: phase,
              builder: (context, signal, child) => Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color.lerp(
                    const Color.fromARGB(45, 36, 110, 90),
                    const Color.fromARGB(34, 83, 83, 83),
                    signal,
                  ),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 15,
                      cornerSmoothing: 1,
                    ),
                    side: const BorderSide(
                      color: Color.fromARGB(133, 172, 214, 175),
                    ),
                  ),
                ),
                child: Center(
                  child: widget.content,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.label,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
