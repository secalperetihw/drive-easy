import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:flutter/material.dart';

class requestPageButton extends StatelessWidget {
  ValueChanged<bool> onPressed;
  String text;
  double? width;
  double? height;
  bool? chosen = false;
  EdgeInsetsGeometry? padding;

  requestPageButton({
    required this.onPressed,
    required this.text,
    this.chosen,
    this.width,
    this.height,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??= EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        width: width ??= MediaQuery.of(context).size.width * 0.2,
        height: height ??= 50,
        decoration: BoxDecoration(
          border: Border.all(color: (chosen ?? false) ? Colors.blue : Colors.grey)
        ),
        child: ElevatedButton(
          onPressed: (){
            chosen = !(chosen ?? false);
            onPressed(chosen ?? false);
          }, 
          child: Container(
            child: Center(
              child: Text(
                text, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: (chosen ?? false) ? Colors.blue : Colors.white,
                  
                ),
              )
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
    
          ),
        ),
      ),
    );
  }
}

class GameAnnoncement extends StatefulWidget {
  GameMain? game;
  Item? item;

  GameAnnoncement({ 
    this.game,
    this.item,
    Key? key 
  }) : super(key: key);

  @override
  State<GameAnnoncement> createState() => _GameAnnoncementState();
}

class _GameAnnoncementState extends State<GameAnnoncement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(10),
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(text: "Score: ", style: TextStyle(color: Colors.white),),
                  TextSpan(text: "  Time now: ", style: TextStyle(color: Colors.white),),
                  TextSpan(text: "  Date: ", style: TextStyle(color: Colors.white),),
                ]
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(text: "Annoncement................... ", style: TextStyle(color: Colors.blue),),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}