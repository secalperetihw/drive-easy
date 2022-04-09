import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';

const String _UP = 'up';
const String _DOWN = 'down';
const String _RIGHT = 'right';
const String _LEFT = 'left';

class Player extends SpriteComponent{
  SpriteAnimation? _animation;
  String direction = '';
  bool moving = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    sprite = await Sprite.load('flatboy/Idle_modified.png');
    width = 0;
    height = 0;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (moving){
      switch (direction){
        case _UP:
          position.y -= 5;
          break;
        case _DOWN:
          position.y += 5;
          break;
        case _RIGHT:
          position.x += 5;
          break;
        case _LEFT:
          position.x -= 5;
          break;
      }
    }
  }

  Future<void> moveTo(Vector2 pos, {bool toCenter = false}) async {
    moving = !moving;

    List<String> directions = await _determineDirection(
      from: position, 
      to: pos,
      toCenter: toCenter
    );

    for (String s in directions){
      direction = s;
      
      switch (direction){
        case _UP:
          while (position.y.toInt() >= pos.y.toInt()) {
            await Future.delayed(const Duration(milliseconds: 50));
          }
          position.y = pos.y;
          break;
        case _DOWN:
          while (position.y.toInt() <= pos.y.toInt()){
            await Future.delayed(const Duration(milliseconds: 50));
          }
          position.y = pos.y;
          break;
        case _RIGHT:
          while (position.x.toInt() <= pos.x.toInt()){
            await Future.delayed(const Duration(milliseconds: 50));
          }
          position.x = pos.x;
          break;
        case _LEFT:
          while (position.x.toInt() >= pos.x.toInt()){
            await Future.delayed(const Duration(milliseconds: 50));
          }
          position.x = pos.x;
          break;
      }
    }
    moving = !moving;
  }

  Future<List<String>> _determineDirection({
    required Vector2 from, 
    required Vector2 to,
    bool toCenter = false
  }) async {
    List<String> result = [];

    //[same x, same y, different x,y]
    if (from.x == to.x){
      
    }

    if (from.y.toInt() > to.y.toInt()){
      result.add(_UP);
    } else if (from.y.toInt() < to.y.toInt()){
      result.add(_DOWN);
    }

    if (from.x > to.x && from.y != to.y){
      result.add(_LEFT);
    } else if (from.x < to.x && from.y != to.y){
      result.add(_RIGHT);
    }

    return result;
  }
}