import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:flutter/material.dart';

class requestDeny extends StatefulWidget {
  Item item;
  ValueChanged<Item> onComplete;
  Function callback;
  double contentHeight;
  double contentWidth;

  requestDeny({ 
    required this.item,
    required this.onComplete,
    required this.callback,
    required this.contentHeight,
    required this.contentWidth,
    Key? key 
  }) : super(key: key);

  @override
  State<requestDeny> createState() => _requestDenyState();
}

class _requestDenyState extends State<requestDeny> {
  List<String> reasons = [
    "Undefined destination",
    "Misterious source",
    "Unsafe encryption",
    "Session Expired",
    "Unmatch type and action"
  ];

  List<bool> _listOfBool = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i=0; i<reasons.length; i++){
      _listOfBool.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: widget.contentWidth,
      height: widget.contentHeight,
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        // verticalDirection: VerticalDirection.down,
        children: [
          Container(
            width: widget.contentWidth * 0.6,
            height: widget.contentHeight * 0.7,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: widget.contentWidth * 0.6,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("What's wrong?", style: TextStyle(color: Colors.white))
                ),
                Container(
                  width: widget.contentWidth * 0.6,
                  height: widget.contentHeight * 0.7,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      itemCount: reasons.length,
                      itemBuilder: ((context, index) {
                        return requestPageButton(
                          chosen: _listOfBool[index],
                          padding: EdgeInsets.all(0),
                          onPressed: (value){
                            setState(() {
                              _listOfBool[index] = value;
                            });
                          },
                          text: reasons[index],
                        );
                      })
                    ),
                  )
                )
              ],
            ),
          ),
          Container(
            width: widget.contentWidth * 0.3,
            height: widget.contentHeight * 0.1,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("", style: TextStyle(color: Colors.white)),
                requestPageButton(
                  width: widget.contentWidth * 0.3,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){
                    widget.onComplete(widget.item);
                  }, 
                  text: "Done"
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.3,
                  height: widget.contentHeight * 0.1,
                  onPressed: (value){
                    widget.callback();
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