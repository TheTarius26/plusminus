import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plusminus/bloc/events/game_event.dart';
import 'package:plusminus/bloc/game_bloc.dart';
import 'package:plusminus/widgets/cell_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late AnimationController _timerController;
  late Animation<Duration> _timerAnimation;

  @override
  void initState() {
    super.initState();

    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 3),
    );

    _timerAnimation = Tween<Duration>(
      begin: const Duration(minutes: 3),
      end: Duration.zero,
    ).animate(_timerController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // context.read<GameBloc>().add(GameOver());
        }
      });

    _timerController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(GameState(
        difficulty: GameDifficulty.easy,
        player: 'Tarius',
      )),
      child: Scaffold(
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Player: ${state.player}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Timer(timerAnimation: _timerAnimation),
                      Text(
                        'Lives: ${state.lives}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${state.point}',
                        style: const TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        defaultColumnWidth: const FixedColumnWidth(100),
                        // children: CellWidget.generateCell(state),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (true)
                    ElevatedButton(
                      onPressed: () {
                        context.read<GameBloc>().add(GameRetryPressed());
                      },
                      child: const Text('Restart'),
                    ),
                  const Spacer()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Color isSelected(CellStatus status) {
    return status == CellStatus.selected ? Colors.blue : Colors.white;
  }
}

class Timer extends StatelessWidget {
  final Animation<Duration> timerAnimation;

  const Timer({
    Key? key,
    required this.timerAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: timerAnimation,
      builder: (context, child) {
        return Text(
          'Time: ${timerAnimation.value.inMinutes}:${timerAnimation.value.inSeconds % 60}',
          style: const TextStyle(fontSize: 20),
        );
      },
    );
  }
}
