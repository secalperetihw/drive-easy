import 'package:drive_easy/game/ui/rules/booksPage.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/books/v1.dart';
import 'package:overlay_tutorial/overlay_tutorial.dart';

class Handbook extends StatefulWidget {
  double contentHeight;
  double contentWidth;
  ValueChanged<double> pageCallback;
  double? page;
  String rulesVersion;
  bool isTutorialEnabled;
  List<bool> isTutorialOn;
  List<OverlayTutorialRectEntry> tutorialOverlaysEntries;
  ValueChanged<Map> tutorialCallback;

  Handbook({ 
    required this.contentHeight,
    required this.contentWidth,
    required this.pageCallback,
    required this.rulesVersion,
    required this.isTutorialEnabled,
    required this.isTutorialOn,
    required this.tutorialOverlaysEntries,
    required this.tutorialCallback,
    this.page,
    Key? key 
  }) : super(key: key);

  @override
  State<Handbook> createState() => _HandbookState();
}

class _HandbookState extends State<Handbook> with AutomaticKeepAliveClientMixin<Handbook>{
  late ScrollController _scrollController;
  int _page = 0;
  int _MAX_PAGE = 0;
  String _loadedData = "";
  Map<String, Function> _buttons = {};
  Map<String, List<String>> _inBookText = {};
  List<String> test = [];


  Future<void> _loadData() async {
    _loadedData = await rootBundle.loadString('assets/textFiles/${widget.rulesVersion}.txt');

    List<String> data = _loadedData.split("\n");
    test = data;
    
    String current = "";
    for (int i=0; i<data.length; i++){
      if (i == 0){
        current = data[0];
        _inBookText.addAll({data[0]: []});
      }
      else if (data[i].contains("//")){
        try {current = data[i+1];} catch(e){break;}
        _inBookText.addAll({data[i+1]: []});
        i++;
      } else if (i != 0) {
        _inBookText[current]?.add(data[i]);
      }
    }

    setState(() {
      _MAX_PAGE = _inBookText.keys.length;
    });
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0);
    _loadData();
    
    _buttons = {
      "Start": (){ 
        _page = 0;
        _scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
      "Policies": (){
        _page = 1;
        _scrollController.animateTo(widget.contentWidth * 0.8 * _page, duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
    };

    _page = 2;
    if (widget.rulesVersion.contains("2") || widget.rulesVersion.contains("3")) {
      _page = 3;
      _buttons.addAll({
        "Auth": () {
          _page = 2;
          _scrollController.animateTo(widget.contentWidth * 0.8 * _page, duration: Duration(milliseconds: 500), curve: Curves.ease);
        }
      });
    }

    if (widget.rulesVersion.contains("4") || widget.rulesVersion.contains("5")) {
      _page = 4;
      _buttons.addAll({
        "Auth": () {
          _page = 2;
          _scrollController.animateTo(widget.contentWidth * 0.8 * _page, duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        "Data": () {
          _page = 3;
          _scrollController.animateTo(widget.contentWidth * 0.8 * _page, duration: Duration(milliseconds: 500), curve: Curves.ease);
        }
      });
    }
    
    int num = 0;
    if (_page == 2) num = 3;
    if (_page == 3) num = 4;
    if (_page == 4) num = 5;
    
    _buttons.addAll({
      "Special": () {
        _page = num;
        _scrollController.animateTo(widget.contentWidth * 0.8 * _page, duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
      "Score": (){
        _page = num+1;
        _scrollController.animateTo(widget.contentWidth * 0.8 * _page, duration: Duration(milliseconds: 500), curve: Curves.ease);
      }
      // "End": (){ 
      //   _page = _MAX_PAGE;
      //   _scrollController.animateTo(widget.contentWidth * 0.8 * _page, duration: Duration(milliseconds: 500), curve: Curves.ease);
      // },
    });

    _page = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.contentWidth,
      height: widget.contentHeight,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          Container(
            height: widget.contentHeight * 0.95,
            width: widget.contentWidth * 0.15,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: 
              ListView(
                children: _buttons.entries.map((e) => 
                  (e.key == "Policies") 
                  ? OverlayTutorialHole(
                    enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[5] : false,
                    overlayTutorialEntry: (widget.isTutorialEnabled) ? widget.tutorialOverlaysEntries[5] : OverlayTutorialRectEntry(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: (){
                          e.value();
                          if (widget.isTutorialEnabled && widget.isTutorialOn[5]) {
                            setState(() {
                              widget.isTutorialOn[5] = false;
                              widget.isTutorialOn[6] = true;
                            });
                          }
                          
                        }, 
                        child: Text(e.key)
                      ),
                    ),
                  )
                  
                  : Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                      onPressed: (){e.value();}, 
                      child: Text(e.key)
                  ))
                ).toList(),
              ),
            )
          ),
          Container(
            padding: EdgeInsets.all(5),
            height: widget.contentHeight * 0.95,
            width: widget.contentWidth * 0.8,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Scrollbar(
                thickness: 5,
                isAlwaysShown: true,
                interactive: true,
                controller: _scrollController,
                trackVisibility: true,
                radius: Radius.circular(10),
                child: Container(
                  child: ListView.builder(
                    itemCount: _inBookText.keys.length,
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) { 
                      Widget wrap = Wrap();
                      try { 
                        wrap = Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.vertical,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              width: widget.contentWidth * 0.38,
                              child: Text(_inBookText.keys.elementAt(index), style: TextStyle(color: Colors.red, fontSize: 20), textAlign: TextAlign.center,)
                            ),
                            for (var i in _inBookText.values.elementAt(index))...[
                              Container(
                                width: widget.contentWidth * 0.38,
                                child: (i.contains("Google Drive")) 
                                ? OverlayTutorialHole(
                                  enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[6] : false,
                                  overlayTutorialEntry: (widget.isTutorialEnabled) ? widget.tutorialOverlaysEntries[6] : OverlayTutorialRectEntry(),
                                  child: Text(i, style: TextStyle(color: Colors.black, fontSize: 15),)
                                )
                                : Text(i, style: TextStyle(color: Colors.black, fontSize: 15),)
                              )
                            ],
                          ],
                        );
                      } catch (e) {}
              
                      if(index == _inBookText.keys.length) {
                        if (widget.isTutorialEnabled) {
                          _scrollController.animateTo(widget.contentWidth * 0.8 * 2, duration: Duration(milliseconds: 0), curve: Curves.ease);
                        }
                      }
                      return Container(
                        padding: EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                          border: Border.all(width: 5, color: Colors.grey),
                          color: Colors.white,
                        ),
                        height: widget.contentHeight * 0.95,
                        // width: widget.contentWidth * 0.8,
                        alignment: Alignment.topCenter,
                        child: wrap,
                      );
                    }
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}