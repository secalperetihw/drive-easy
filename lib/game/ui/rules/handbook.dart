import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_turn/page_turn.dart';

class Handbook extends StatefulWidget {
  double contentHeight;
  double contentWidth;
  ValueChanged<int> pageCallback;
  int? page;

  Handbook({ 
    required this.contentHeight,
    required this.contentWidth,
    required this.pageCallback,
    this.page,
    Key? key 
  }) : super(key: key);

  @override
  State<Handbook> createState() => _HandbookState();
}

class _HandbookState extends State<Handbook> {
  late ScrollController _scrollController;
  int _page = 0;
  int _MAX_PAGE = 4;

  Map<String, Function> _buttons = {};
  Map<String, List<String>> _inBookText = {};


  Future<void> _loadData() async {
    final _loadedData = await rootBundle.loadString('assets/textFiles/rules.txt');
    // print(_loadedData);

    List<String> data = _loadedData.split("\n");
    
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
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0);

    _buttons = {
      "Right": (){ 
        if(_page < _MAX_PAGE) _page++;
        _scrollController.animateTo(widget.contentWidth * 0.8 * _page, duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
      "Left": (){ 
        if(_page > 0) _page--;
        _scrollController.animateTo(widget.contentWidth * 0.8 * _page, duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
      "Start": (){ 
        _page = 0;
        _scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
      "End": (){ 
        _page = _MAX_PAGE;
        _scrollController.animateTo(widget.contentWidth * 0.8 * _page, duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
    };

    _loadData();
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
                  ElevatedButton(
                    onPressed: (){e.value();}, 
                    child: Text(e.key)
                  )
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
              child: ListView(
                scrollDirection: Axis.horizontal,
                // onPageChanged: (value){
                //   widget.pageCallback(value);
                // },
                controller: _scrollController,
                children: [
                  for (int k=0; k<=(_inBookText.keys.length + 1) / 2; k+=2)...[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.grey),
                        color: Colors.white,
                      ),
                      height: widget.contentHeight * 0.95,
                      width: widget.contentWidth * 0.8,
                      alignment: Alignment.topCenter,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.vertical,
                        children: [
                          for (int j=k; j<((_inBookText.keys.length < 2) ? _inBookText.keys.length + k : 2 + k); j++)...[
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              width: widget.contentWidth * 0.38,
                              child: Text(_inBookText.keys.elementAt(j), style: TextStyle(color: Colors.red, fontSize: 20), textAlign: TextAlign.center,)
                            ),
                            
                            for (var i in _inBookText.values.elementAt(j))...[
                              Container(
                                width: widget.contentWidth * 0.38,
                                child: Text(i, style: TextStyle(color: Colors.black, fontSize: 15),)
                              )
                            ],
                            if (j % 2 == 0) VerticalDivider(thickness: 5,)
                          ]
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}