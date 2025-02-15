import 'package:flutter/material.dart';
import 'package:vibes/elements/oscillating_builder.dart';
import 'package:vibes/manager/view/manager_content.dart';

class ManagerScreen extends StatelessWidget {
  const ManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OscillatingBuilder(
      minValue: 0,
      maxValue: 1,
      period: 5,
      builder: (context, signal, child) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(
                const Color.fromARGB(255, 16, 17, 95),
                const Color.fromARGB(255, 22, 51, 123),
                signal,
              )!,
              Color.lerp(
                const Color.fromARGB(255, 10, 20, 46),
                const Color.fromARGB(255, 7, 8, 44),
                signal,
              )!,
            ],
          ),
        ),
        child: child,
      ),
      staticChild: const Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: ManagerContent()),
      ),
    );
  }
}
