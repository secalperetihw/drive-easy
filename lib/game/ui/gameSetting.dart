import 'package:drive_easy/classes/game/progress.dart';
import 'package:flutter/material.dart';

class GameSetting extends StatefulWidget {
  Progress progress;
  double contentHeight;
  double contentWidth;
  ValueChanged<Map> callback;

  GameSetting({ 
    Key? key,
    required this.progress,
    required this.contentHeight,
    required this.contentWidth,
    required this.callback,
  }) : super(key: key);

  @override
  State<GameSetting> createState() => _GameSettingState();
}

class _GameSettingState extends State<GameSetting> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return Container(
      height: widget.contentHeight,
      width: widget.contentWidth,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1, color: Colors.white)
      ),
      child: Wrap(children: [
        Row(
          children: [
            Checkbox(
              // activeColor: Colors.white,
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: widget.progress.realMode ?? false, 
              onChanged: (value) {
                setState(() {
                  widget.progress.realMode = !(widget.progress.realMode ?? false);
                  widget.callback({"progress": widget.progress});
                });
              }
            ),
            Text("Toggle real mode", style: TextStyle(color: Colors.white),)
          ],
        ),
      ]),
    );
  }
}