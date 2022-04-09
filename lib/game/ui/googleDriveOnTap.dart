import 'package:drive_easy/game/game_home.dart';
import 'package:flutter/material.dart';

class googleDriveOnTap extends StatefulWidget {
  const googleDriveOnTap({
    Key? key,
    required this.ctx,
    required this.game,
  }) : super(key: key);
  final BuildContext ctx;
  final GameMain game;

  @override
  State<googleDriveOnTap> createState() => _googleDriveOnTapState();
}

class _googleDriveOnTapState extends State<googleDriveOnTap> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Center(
          child: ElevatedButton(
            child: Text("click" + widget.game.data.toString()),
            onPressed: (){
              widget.game.overlays.remove('googleDriveOnTap');
              setState(() {
                widget.game.data = (int.parse(widget.game.data ?? '0') + 1).toString();
              });
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

