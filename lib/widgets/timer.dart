import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  final AnimationController timerController;
  final int duration;

  const Timer({
    Key? key,
    required this.timerController,
    required this.duration,
  }) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
      duration: Duration(minutes: widget.duration),
      tween: Tween(
        begin: Duration(minutes: widget.duration),
        end: Duration.zero,
      ),
      builder: (context, value, child) {
        return Text(
          value.toString().split('.')[0],
          style: const TextStyle(
            fontSize: 30,
          ),
        );
      },
    );
  }
}
