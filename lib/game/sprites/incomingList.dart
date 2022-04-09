import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';

class IncomingList extends SpriteComponent with Tappable{

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await Sprite.load('icons/images/button_75.png');
    width = 50;
    height = 50;
    anchor = Anchor.center;

   
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (parent is FlameGame) {
      !(parent as FlameGame).paused ? (parent as FlameGame).overlays.add('incoming') : null;
    }
    return true;
  }
}