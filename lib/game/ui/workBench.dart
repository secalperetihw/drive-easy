import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/game/ui/requestPage/modify.dart';
import 'package:drive_easy/game/ui/requestPage/request.dart';
import 'package:drive_easy/global.dart';
import 'package:flutter/material.dart';

class workBench extends StatefulWidget {
  const workBench({
    Key? key,
    required this.context,
    required this.ctx,
    required this.game,
  }) : super(key: key);

  final BuildContext context;
  final BuildContext ctx;
  final GameMain game;

  @override
  State<workBench> createState() => _workBenchState();
}

class _workBenchState extends State<workBench> {
  @override
  Widget build(BuildContext context) {
    return Stack(
    
      children: [
        GestureDetector(
          onTap: (){
            widget.game.overlays.remove('workBench');
          },
        ),
        Center(
          child: Container(
            height: MediaQuery.of(widget.context).size.height * 0.6,
            width: MediaQuery.of(widget.context).size.width * 0.8,
            decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Colors.black)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              
            ),
            child: ListView(
              children: 
                widget.game.itemHolding.map((e) => 
                  Column(
                    children: [
                      Center(
                        child: onHoldItem(
                          item: e, 
                          onModify: () async {
                            // await Navigator.push(
                            //   widget.ctx, 
                            //   MaterialPageRoute(
                            //     builder: ((context) =>  RequestMainPage(
                            //       itemCallback: (value) {
                                    
                            //       },
                            //       progress: progress,
                            //       game: widget.game,
                            //       item: e,
                            //     ))
                            //   )
                            // );
                          },
                          onReturn: (){
                            setState(() {
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

class onHoldItem extends StatelessWidget {
  onHoldItem({
    Key? key,
    required this.item,
    required this.onModify,
    required this.onReturn,
  }) : super(key: key);

  final Function onModify;
  final Function onReturn;
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
              Text(Item.convert(item.encryption) ?? ""),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  onModify();
                }, 
                child: Text("modify")
              ),
              ElevatedButton(
                onPressed: (){
                  onReturn();
                }, 
                child: Text("return")
              ),
            ],
          )
        ],
      ),
    );
  }

}
