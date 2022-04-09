import 'package:drive_easy/game/game_home.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:flame/layers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String _UP = 'up';
const String _DOWN = 'down';
const String _RIGHT = 'right';
const String _LEFT = 'left';

class WorkBench extends SpriteComponent with Tappable{
  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await Sprite.load('icons/images/button_57.png');
    width = 50;
    height = 50;
    anchor = Anchor.center;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (parent is FlameGame) {
      !(parent as FlameGame).paused ? (parent as FlameGame).overlays.add('workBench') : null;
    }

    return true;
  }
}

// class counter extends DynamicLayer {
//   final GameMain game;

//   counter(this.game);

//   @override
//   void drawLayer() {
//     game.workBench.render(
//       Canvas(recorder)
//     );
//   }

// }

class MyPainter extends CustomPainter {
  MyPainter(this.text);

  String text;

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  }
  
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}