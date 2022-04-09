import 'package:drive_easy/game/game_home.dart';
import 'package:flutter/material.dart';

class pauseMenu extends StatelessWidget {
  const pauseMenu({
    Key? key,
    required this.ctx,
    required this.game,
  }) : super(key: key);

  final BuildContext ctx;
  final GameMain game;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Center(
          child: ElevatedButton(
            child: Icon(Icons.play_arrow),
            onPressed: (){
              game.resumeEngineFn!();
              game.paused = !game.paused;
              game.overlays.remove('pauseMenu');
            },
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
      )
    );
  }
}

class pauseButton extends StatelessWidget {
  const pauseButton({
    Key? key,
    required this.ctx,
    required this.game,
  }) : super(key: key);

  final BuildContext ctx;
  final GameMain game;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        game.pauseEngineFn!();
        game.paused = !game.paused;
        game.overlays.add('pauseMenu');
      }, 
      child: const Icon(
        Icons.pause,
        color: Colors.white,
      )
    );
  }
}