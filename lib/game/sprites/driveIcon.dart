import 'package:drive_easy/game/sprites/player.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';

const String _UP = 'up';
const String _DOWN = 'down';
const String _RIGHT = 'right';
const String _LEFT = 'left';

class DriveIcon extends SpriteComponent with Tappable{

  DriveIcon(this.icon);

  String icon;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await Sprite.load(icon);
    anchor = Anchor.center;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    Player? player = parent?.children.whereType<Player>().first;
    player!.moveTo(Vector2(position.x + 50, position.y));

    return true;
  }
}