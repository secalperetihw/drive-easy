import 'dart:math';
import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/game/sprites/driveIcon.dart';
import 'package:drive_easy/game/sprites/incomingList.dart';
import 'package:drive_easy/game/sprites/player.dart';
import 'package:drive_easy/game/sprites/workBench.dart';
import 'package:drive_easy/game/ui/background.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:drive_easy/game/ui/googleDriveOnTap.dart';
import 'package:drive_easy/game/ui/incoming.dart';
import 'package:drive_easy/game/ui/pause.dart';
import 'package:drive_easy/game/ui/workBench.dart';
import 'package:flutter/services.dart';
// import 'package:googleapis/compute/v1.dart';

class GameMainWithOverlays extends StatelessWidget {
  GameMainWithOverlays({
    Key? key,
  }) : super(key: key);

  final GameMain game = GameMain();

  Future<void> init() async {
    await Flame.device.setLandscape();
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done){
          return Center(child: CircularProgressIndicator(),);
        }
        else {
          return Scaffold(
            body: GameWidget(
              key: UniqueKey(),
              game: game,
              backgroundBuilder: (ctx){
                return GameBackground(ctx: ctx);
              },
              overlayBuilderMap: {
                'googleDriveOnTap': (ctx, GameMain game) {
                  return googleDriveOnTap(ctx: ctx, game: game,);
                },
                'pauseButton': (ctx, GameMain game){
                  return pauseButton(ctx: ctx, game: game);
                },
                'pauseMenu': (ctx, GameMain game){
                  return pauseMenu(ctx: ctx, game: game);
                },
                'computer': (ctx, GameMain game){
                  return workBench(context: context, ctx: ctx, game: game);
                },
                'incoming': (ctx, GameMain game){
                  return incoming(context: context, ctx: ctx, game: game);
                }
              },
            ),
          );
        }
      }
    );
  }
}


class GameMain extends FlameGame with HasTappables {
  late Player player;
  late DriveIcon driveIcon;
  late DriveIcon driveIcon2;
  late DriveIcon driveIcon3;
  late DriveIcon driveIcon4;
  // late DriveIcon home;
  late WorkBench workBench;
  late IncomingList incomingCache;
  final googleDriveOnTap = 'googleDriveOnTap';
  // late Timer timer;
  late CustomPainterComponent counter;
  String? data = "1";
  List<Item> incoming = [];
  List<Item> itemHolding = [];
  var ran = Random();
  Function setPortrait = (){
    Flame.device.setPortrait();
  };

  Function setLandscape = (){
    Flame.device.setLandscape();
  };

  GameMain({
    this.data,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    

    player = Player()
      ..position = Vector2(size.x * 0.8, size.y * 0.5);
    driveIcon = DriveIcon('drives/drive_2020q4_48dp.png')
      ..position = Vector2(size.x * 0.2, size.y * 0.2)
      ..height = 50
      ..width = 50;
    driveIcon2 = DriveIcon('drives/onedrive.png')
      ..position = Vector2(size.x * 0.2, size.y * 0.4)
      ..height = 45
      ..width = 60;
    driveIcon3 = DriveIcon('drives/2560px-ICloud_logo.svg.png')
      ..position = Vector2(size.x * 0.2, size.y * 0.6)
      ..height = 45
      ..width = 60;
    driveIcon4 = DriveIcon('drives/1101px-Dropbox_Icon.svg.png')
      ..position = Vector2(size.x * 0.2, size.y * 0.8)
      ..height = 45
      ..width = 60;
    // home = DriveIcon()
    //   ..position = Vector2(size.x * 0.8, size.y * 0.5);
    workBench = WorkBench()
      ..position  = Vector2(size.x * 0.8, size.y * 0.3);
    incomingCache = IncomingList()
      ..position  = Vector2(size.x * 0.8, size.y * 0.7);
    counter = CustomPainterComponent(
      painter: MyPainter(incoming.length.toString()),
    ) ..position  = Vector2(size.x * 0.9, size.y * 0.6);
    
    add(player);
    add(driveIcon);
    add(driveIcon2);
    add(driveIcon3);
    add(driveIcon4);
    // add(home);
    add(workBench);
    add(incomingCache);
    add(counter);
    overlays.add('pauseButton');

    // timer = Timer(
    //   5 + ran.nextInt(10 - 5).toDouble(),
    //   onTick: (){
    //     incoming.add(Item.generate());
    //     // incoming.add((incoming.length + 1).toString());
    //     // counter.painter!.shouldRepaint(MyPainter(incoming.length.toString()));
    //     // counter = CustomPainterComponent(
    //     //   painter: MyPainter(incoming.length.toString()),
    //     // ) ..position  = Vector2(size.x * 0.9, size.y * 0.6);
    //   },
    //   repeat: true,
    // );

    
    
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    
  }

  @override
  void update(double dt) {
    super.update(dt);

    // timer.update(dt);
  }

  @override
  void onDetach() {
    // TODO: implement onDetach
    super.onDetach();
    Flame.device.setPortrait();
  }
}

