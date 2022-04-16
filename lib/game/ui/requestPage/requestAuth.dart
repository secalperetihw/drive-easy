import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:drive_easy/global.dart';
import 'package:flutter/material.dart';

class requestAuth extends StatefulWidget {
  Item item;
  Function backButton;
  ValueChanged<Item> itemCallback;
  double contentHeight;
  double contentWidth;

  requestAuth({ 
    required this.itemCallback,
    required this.item,
    required this.backButton,
    required this.contentHeight,
    required this.contentWidth,
    Key? key 
  }) : super(key: key);

  @override
  State<requestAuth> createState() => _requestAuthState();
}

class _requestAuthState extends State<requestAuth> {
  Map<String, bool> chosenType = {
    "POST": false,
    "GET": false,
  };
  String? type;
  int displayvalue = 0;
  int displayRequestType = 0;

  List<String> scopes = [
    "Read only",
    "Write to app folder",
    "Metadata only",
    "All access",
  ];

  List<String> httpType = ["GET", "POST", "PUT", "DELETE", "PATCH"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        verticalDirection: VerticalDirection.down,
        children: [
          Container(
            width: widget.contentWidth * 0.3,
            height: widget.contentHeight * 0.5,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("Request: ", style: TextStyle(color: Colors.white)),
                DropdownButton(
                  value: displayRequestType,
                  onChanged: (int? value){
                    // type = value.toString();
                    setState(() {
                      displayRequestType = value ?? 0;
                    });
                    
                  },
                  items: ActionType.values.map((e) => DropdownMenuItem(
                      value: ActionType.values.indexOf(e),
                      child: Text(Item.convert(e))
                    )).toList(),
                  selectedItemBuilder: (ctx) {
                    return ActionType.values.map((e) => Container(
                      width: widget.contentWidth * 0.2,
                      decoration: BoxDecoration(
                        // border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
                      ),
                      padding: EdgeInsets.all(1),
                      child: Center(child: Text(Item.convert(e), style: TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)),
                    )).toList();
                  },
                ),
              ],
            ),
          ),
          Container(
            width: widget.contentWidth * 0.4,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("Scope: ", style: TextStyle(color: Colors.white)),
                DropdownButton(
                  value: displayvalue,
                  onChanged: (int? value){
                    // type = value.toString();
                    setState(() {
                      displayvalue = value ?? 0;
                    });
                    
                  },
                  items: scopes.map((e) => DropdownMenuItem(
                      value: scopes.indexOf(e),
                      child: Text(e)
                    )).toList(),
                  selectedItemBuilder: (ctx) {
                    return scopes.map((e) => Container(
                      width: widget.contentWidth * 0.3,
                      decoration: BoxDecoration(
                        // border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
                      ),
                      padding: EdgeInsets.all(1),
                      child: Center(child: Text(e, style: TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)),
                    )).toList();
                  },
                ),
              ],
            ),
          ),
          Container(
            width: widget.contentWidth * 0.3,
            height: widget.contentHeight * 0.5,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("Hidden^^", style: TextStyle(color: Colors.black)),
                requestPageButton(
                  width: widget.contentWidth * 0.3,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){
                    setState(() {
                      widget.item.authenticating = true;
                      widget.itemCallback(widget.item);
                    });
                  }, 
                  text: "Send"
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.3,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){
                    widget.backButton();
                  }, 
                  text: "Back"
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

