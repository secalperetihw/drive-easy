import 'dart:math';

import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/global.dart';
import 'package:flutter/material.dart';

class incoming extends StatefulWidget {
  const incoming({
    Key? key,
    required this.context,
    required this.ctx,
    required this.game,
  }) : super(key: key);

  final BuildContext context;
  final BuildContext ctx;
  final GameMain game;

  @override
  State<incoming> createState() => _incomingState();
}

class _incomingState extends State<incoming> {
  @override
  Widget build(BuildContext context) {
    return Stack(
    
      children: [
        GestureDetector(
          onTap: (){
            widget.game.overlays.remove('incoming');
          },
        ),
        Center(
          child: Container(
            height: MediaQuery.of(widget.context).size.height * 0.7,
            width: MediaQuery.of(widget.context).size.width * 0.8,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              
            ),
            child: ListView(
              children: 
                widget.game.incoming.map((e) => 
                  Column(
                    children: [
                      Center(
                        child: incomingItem(
                          item: e, 
                          onGet: (){
                            setState(() {
                              widget.game.incoming.remove(e);
                              widget.game.itemHolding.add(e);
                            });
                          },
                          onDismiss: (){
                            setState(() {
                              widget.game.incoming.remove(e);
                            });
                          },
                        )
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.grey,
                      )
                    ],
                  )
                ).toList(),
                
              
            ),
          ),
        ),
      ]
    );
  }
}

class incomingItem extends StatelessWidget {
  incomingItem({
    Key? key,
    required this.item,
    required this.onGet,
    required this.onDismiss,
  }) : super(key: key);

  final Function onGet;
  final Function onDismiss;
  Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Item.convertToImage(item.source!),
              const Icon(Icons.drive_file_move_outlined),
              Item.convertToImage(item.destination!)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(item.name.toString()),
              Text(Item.convert(item.fileType).toString()),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  onGet();
                }, 
                child: Text("get")
              ),
              ElevatedButton(
                onPressed: (){
                  onDismiss();
                }, 
                child: Text("dismiss")
              ),
            ],
          )
        ],
      ),
    );
  }

}