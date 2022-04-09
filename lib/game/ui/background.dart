import 'package:drive_easy/game/game_home.dart';
import 'package:flutter/material.dart';

class GameBackground extends StatefulWidget {
  GameBackground({ 
    Key? key,
    required this.ctx,
  }) : super(key: key);

  BuildContext ctx;

  @override
  _GameBackgroundState createState() => _GameBackgroundState();
}

class _GameBackgroundState extends State<GameBackground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background/background.jpg"),
            fit: BoxFit.fill
          )
        ),
        
      ),
    );
  }
}