import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/game/ui/requestPage/modify.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:drive_easy/game/ui/requestPage/requestContent.dart';
import 'package:drive_easy/game/ui/rules/handbook.dart';
import 'package:drive_easy/global.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/androidmanagement/v1.dart';
import 'package:overlay_tutorial/overlay_tutorial.dart';

class RequestMainPage extends StatefulWidget {
  GameMain? game;
  Item item;
  Progress progress;
  Map<String, dynamic>? info;
  ValueChanged<Item> itemCallback;
  int tutorialOffset;
  bool tutorial;
  DateTime timeNow;
  int? displaylevel;
  ValueChanged<Progress> progressCallback;
  // ValueChanged<Duration> timeCallback;

  RequestMainPage({ 
    this.game,
    required this.item,
    required this.progress,
    required this.itemCallback,
    required this.tutorialOffset,
    required this.tutorial,
    required this.timeNow,
    this.displaylevel,
    required this.progressCallback,
    this.info,
    Key? key 
  }) : super(key: key);

  @override
  State<RequestMainPage> createState() => _RequestMainPageState();
}

class _RequestMainPageState extends State<RequestMainPage> {
  late PageController pageController;
  Widget? content;
  int current = 0;
  int MAX_PAGE = 2;
  int contentPage = 0;
  double rulesPage = 0;
  bool toDataPage = false;
  bool showArrow = true;
  bool _isTutorialEnabled = true;
  List<bool> _isTutorialOn = [];
  List<OverlayTutorialRectEntry> tutorialOverlaysEntries = [];
  Widget announcement = Container();
  double dataScrollOffset = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: 0);

    _isTutorialOn = [
      false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
      false, false, false, false, false, false
    ];

    if (widget.tutorialOffset == 0) {
      _isTutorialOn[0] = true;
    } else if (widget.tutorialOffset == 1) {
      _isTutorialOn[3] = true;
    } else if (widget.tutorialOffset == 999) {
      _isTutorialOn[11] = true;
    }
    if (widget.progress.tutorial!["Authorization"]! && widget.progress.level == 2) {
      
      _isTutorialEnabled = widget.progress.tutorial!["Authorization"]!;
      _isTutorialOn[14] = true;
      _isTutorialOn[0] = false;
    } else if (widget.progress.tutorial!["FirstPlay"]! && widget.progress.level == 0) {
      _isTutorialEnabled = widget.progress.tutorial!["FirstPlay"]!;
    } else if (widget.progress.tutorial!["Data"]! && widget.progress.level == 4) {
      _isTutorialEnabled = widget.progress.tutorial!["Data"]!;
      _isTutorialOn[17] = true;
      _isTutorialOn[0] = false;
    } else {
      _isTutorialEnabled = false;
    }

    tutorialOverlaysEntries = [
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top,
                left: entryRect.rRect!.right,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text(
                    
                    'Here you can inspect this basic information of each packages,\nbut let\'s assume it is correct first,\nas I\'m here for teaching you the operation.',
                    
                  ),
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.right,
                child: GestureDetector(
                  onTap: () {
                    if (_isTutorialEnabled && _isTutorialOn[0]) {
                      setState(() {
                        _isTutorialOn[0] = false;
                        _isTutorialOn[1] = true;
                      });
                    }
                  },
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline,),
                    child: Text('Click to continue',)
                  ),
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top,
                left: (entryRect.rRect!.left + entryRect.rRect!.right) / 2,
                child: Icon(Icons.arrow_downward, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top - 24,
                left: entryRect.rRect!.left,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text('Click here to approve the packages',)
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top,
                left: entryRect.rRect!.right,
                child:  DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text('In this package there is a suspicious field,\nhere we can see the destination have something wrong',)
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.bottom,
                left: entryRect.rRect!.right,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.blue,),
                  child: GestureDetector(
                    onTap: () {
                      if(_isTutorialEnabled && _isTutorialOn[3]) {
                        setState(() {
                          _isTutorialOn[3] = false;
                          _isTutorialOn[4] = true;
                        });
                      }
                    },
                    child: Text('Continue', style: TextStyle(decoration: TextDecoration.underline),)
                  )
                ),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top,
                left: entryRect.rRect!.right,
                child:  DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text('Why I know that?\nCheck out our company policy to know why!',)
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.right,
                child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.bottom,
                left: entryRect.rRect!.left,
                child:  DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text('Here we can see that the correct one is Google Drive!',)
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.bottom + 24,
                left: entryRect.rRect!.left,
                child:  DefaultTextStyle(
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  child: GestureDetector(
                    onTap: () {
                      if (_isTutorialEnabled && _isTutorialOn[6]) {
                        setState(() {
                          _isTutorialOn[6] = false;
                          _isTutorialOn[7] = true;
                        });
                      }
                    },
                    child: Text('Continue',)
                  )
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.bottom,
                left: entryRect.rRect!.left + 24,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text('Click here to go back',)
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.right,
                child: Icon(Icons.arrow_back, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top - 24,
                left: entryRect.rRect!.left,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text('Click here to deny the packages',)
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top - 24,
                left: entryRect.rRect!.left,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text('Choose the correct reason!',)
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top,
                left: entryRect.rRect!.right,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text(
                    
                    'Here we can clearly see that this is suspicious according to our policy,\nbut for tutorial, let\'s approve this packages to see what will happened',
                    
                  ),
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.right,
                child: GestureDetector(
                  onTap: () {
                    if (_isTutorialEnabled && _isTutorialOn[11]) {
                      setState(() {
                        _isTutorialOn[11] = false;
                        _isTutorialOn[12] = true;
                      });
                    }
                  },
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline,),
                    child: Text('Click to continue',)
                  ),
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top,
                left: (entryRect.rRect!.left + entryRect.rRect!.right) / 2,
                child: Icon(Icons.arrow_downward, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top - 24,
                left: entryRect.rRect!.left,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text('Click here to authorize the source of package',)
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top - 24,
                left: entryRect.rRect!.left,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text('Choose correct action correspond to request',)
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top - 24,
                left: entryRect.rRect!.left,
                child: GestureDetector(
                  onTap: () {
                    if (_isTutorialEnabled && _isTutorialOn[16]) {
                      setState(() {
                        _isTutorialEnabled = false;
                        _isTutorialOn[16] = false;
                        widget.progress.tutorial!["Authorization"] = false;
                      });
                    }
                  },
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white,),
                    child: RichText(textAlign: TextAlign.center, text: TextSpan(children: const [
                      TextSpan(text: 'You can consult the policy to check what to choose!\n',),
                      TextSpan(text: 'Continue', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline))
                    ]))
                  ),
                ),
              );
            },
          ),
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: (entryRect.rRect!.top + entryRect.rRect!.bottom) / 2,
                left: entryRect.rRect!.left - 24,
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.top - 48,
                left: (entryRect.rRect!.left + entryRect.rRect!.right) / 2,
                child:  DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: Text('You can see a code has been injected to this package.\nClick the red text, then click fliter.',)
                ),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Positioned(
                top: entryRect.rRect!.bottom,
                left: (entryRect.rRect!.left + entryRect.rRect!.right) / 2,
                child: Icon(Icons.arrow_upward, color: Colors.white),
              );
            },
          ),
        ],
      ),
      OverlayTutorialRectEntry(
        padding: const EdgeInsets.all(8.0),
        radius: const Radius.circular(16.0),
        overlayTutorialHints: [
          OverlayTutorialWidgetHint(
            // position: (rect) => Offset(rect.center.dx - 50, rect.center.dy),
            builder: (context, entryRect) {
              return Center(
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white,),
                  child: RichText(textAlign: TextAlign.center, text: TextSpan(children: [
                    TextSpan(text: 'Now you should consult the handbook to see what to do!\n\n',),
                    TextSpan(
                      text: "OK!", 
                      style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        setState(() {
                          _isTutorialOn[19] = false;
                          _isTutorialEnabled = false;
                          widget.progress.tutorial!["Data"] = false;
                          widget.progressCallback(widget.progress);
                        });
                      }
                    )
                  ]),)
                ),
              );
            },
          ),
        ],
      ),
    ];
  }

  // @override
  // void dispose() {
  //   super.dispose();

  //   widget.timeCallback(widget.item.timeNeeded!);
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return OverlayTutorialScope(
      enabled: _isTutorialEnabled,
      overlayColor: Colors.black.withOpacity(.8),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.black,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white
          ),
          leading: OverlayTutorialHole(
            enabled: (_isTutorialEnabled) ? _isTutorialOn[7] : false,
            overlayTutorialEntry: tutorialOverlaysEntries[7],
            child: IconButton(
              icon: const Icon(Icons.arrow_back), 
              onPressed: () async {
                if (widget.item.finish == true) {
                  Navigator.pop(context);
                  return;
                }
                if (pageController.page == 0){
                  bool exit = false;
                  await showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) { 
                    
                      return AlertDialog(
                        title: Text("Exit"),
                        content: Text("Are you sure to exit?\nSome of the progress will wipe out.", style: TextStyle(color: Colors.red),),
                        actions: [
                          TextButton(
                            onPressed:(){
                              exit = true;
                              Navigator.pop(context);
                            }, 
                            child: Text("Yes")
                          ),
                          TextButton(
                            onPressed:(){
                              exit = false;
                              Navigator.pop(context);
                            }, 
                            child: Text("No")
                          )
                        ],
                      );
                    }
                  );
                  if(exit){
                    Navigator.pop(context);
                  }
                } else {
                  if (_isTutorialEnabled && _isTutorialOn[7]) {
                    setState(() {
                      _isTutorialOn[7] = false;
                      _isTutorialOn[8] = true;
                    });
                  }
                  current--;
                  pageController.animateToPage(current, duration: Duration(milliseconds: 100), curve: Curves.ease);
                }
              },
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: popupClicked,
              itemBuilder: (BuildContext context) {
                return {'View Handbook', 'Policies', 'Setting', 'Help', 'Debug', 'Debug 1'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.end,
                alignment: WrapAlignment.end,
                children: [
                  OverlayTutorialHole(
                    enabled: (_isTutorialEnabled) ? _isTutorialOn[19] : false,
                    overlayTutorialEntry: tutorialOverlaysEntries[21],
                    child: Container()
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(child: GameAnnoncement(
                      item: widget.item, 
                      annoncement: announcement,
                      time: widget.timeNow,
                    ))
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: PageView(
                      onPageChanged: (page){
                        if (current != page) { setState(() { current = page; });}
                        if (page == 2){
                          setState(() {
                            showArrow = !showArrow;
                          });
                        }
                        else if (page != 2 && !showArrow){
                          setState(() {
                            showArrow = !showArrow;
                          });
                        }
                      },
                      scrollDirection: Axis.vertical,
                      controller: pageController,
                      children: [
                        requestContents(
                          displaylevel: widget.displaylevel,
                          annoncementCallback: (value) {
                            setState(() {
                              announcement = value;
                            });
                          },
                          isTutorialEnabled: _isTutorialEnabled,
                          isTutorialOn: _isTutorialOn,
                          tutorialOverlaysEntries: tutorialOverlaysEntries,
                          tutorialCallback: (value) {
                            if (value["isTutorialEnabled"] != null) {
                              setState(() {
                                _isTutorialEnabled = value["isTutorialEnabled"];
                              });
                            }
                            if (value["isTutorialOn"] != null) {
                              setState(() {
                                _isTutorialOn = value["isTutorialOn"];
                              });
                            }
                            if (value["tutorialOverlaysEntries"] != null) {
                              setState(() {
                                tutorialOverlaysEntries = value["tutorialOverlaysEntries"];
                              });
                            }
                          },
                          contentHeight: MediaQuery.of(context).size.height * 0.8,
                          contentWidth: MediaQuery.of(context).size.width,
                          game: widget.game,
                          item: widget.item,
                          progress: widget.progress,
                          callback: (value){
                            setState(() {
                              widget.item = value;
                            });
                          },
                          pageCallback: (value){
                            setState(() {
                              contentPage = value;
                            });
                          },
                          dataCallback: (value){
                            current = 2;
                            pageController.animateToPage(current, duration: Duration(milliseconds: 700), curve: Curves.ease);
                            setState(() {
                              showArrow = false;
                            });
                          },
                          itemCallback: (value) {
                            setState(() {
                              widget.item = value;
                              widget.itemCallback(value);
                            });
                          },
                          page: contentPage,
                        ),
                        Handbook(
                          isTutorialEnabled: _isTutorialEnabled,
                          isTutorialOn: _isTutorialOn,
                          tutorialOverlaysEntries: tutorialOverlaysEntries,
                          tutorialCallback: (value) {
                            if (value["isTutorialEnabled"] != null) {
                              setState(() {
                                _isTutorialEnabled = value["isTutorialEnabled"];
                              });
                            }
                            if (value["isTutorialOn"] != null) {
                              setState(() {
                                _isTutorialOn = value["isTutorialOn"];
                              });
                            }
                            if (value["tutorialOverlaysEntries"] != null) {
                              setState(() {
                                tutorialOverlaysEntries = value["tutorialOverlaysEntries"];
                              });
                            }
                          },
                          rulesVersion: "rules-version" + (widget.progress.level ?? 0).toString(),
                          contentHeight: MediaQuery.of(context).size.height * 0.8,
                          contentWidth: MediaQuery.of(context).size.width,
                          pageCallback: (value){
                            setState(() {
                              rulesPage = value;
                            });
                          },
                          page: rulesPage,
                        ),
                        if ((widget.displaylevel ?? widget.progress.level!) >= 4)
                          modifyPage(
                            isTutorialEnabled: _isTutorialEnabled,
                            isTutorialOn: _isTutorialOn,
                            tutorialOverlaysEntries: tutorialOverlaysEntries,
                            contentHeight: MediaQuery.of(context).size.height * 0.8,
                            contentWidth: MediaQuery.of(context).size.width,
                            item: widget.item,
                            progress: widget.progress,
                            scrollOffset: dataScrollOffset,
                            callback: (value) {
                              setState(() {
                                if (value["progress"] != null) widget.progress = value["progress"];
                                if (value["scrollOffset"] != null) dataScrollOffset = value["scrollOffset"];
                                if (value["item"] != null) {
                                  widget.item = value["item"];
                                  widget.itemCallback(widget.item);
                                }
                                if (value["isTutorialEnabled"] != null) {
                                  setState(() {
                                    _isTutorialEnabled = value["isTutorialEnabled"];
                                  });
                                }
                                if (value["isTutorialOn"] != null) {
                                  setState(() {
                                    _isTutorialOn = value["isTutorialOn"];
                                  });
                                }
                                if (value["tutorialOverlaysEntries"] != null) {
                                  setState(() {
                                    tutorialOverlaysEntries = value["tutorialOverlaysEntries"];
                                  });
                                }
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ]
              ),
              if (showArrow) Container(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
                alignment: Alignment.bottomCenter,
                child: OverlayTutorialHole(
                  enabled: (_isTutorialEnabled) ? _isTutorialOn[4] : false,
                  overlayTutorialEntry: tutorialOverlaysEntries[4],
                  child: IconButton(
                    iconSize: 20,
                    icon: Icon(Icons.arrow_downward, color: (current == 1) ? Colors.red : Colors.white, size: 20,), 
                    onPressed: (){
                      if (current < MAX_PAGE) current++;
                      if (_isTutorialEnabled && _isTutorialOn[4]) {
                        setState(() {
                          _isTutorialOn[4] = false;
                          _isTutorialOn[5] = true;
                        });
                      }
                      pageController.animateToPage(current, duration: Duration(milliseconds: 700), curve: Curves.ease);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void popupClicked(String value) {
    switch(value){
      case 'View Handbook':
        pageController.animateToPage(1, duration: Duration(milliseconds: 100), curve: Curves.ease);
        break;
      case 'Debug':
        Flame.device.setLandscape();
        // SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.landscapeLeft,
        //   DeviceOrientation.landscapeRight
        // ]);
        // setState(() {
        //   widget.game.setLandscape();
        // });
        // Flame.device.fullScreen();
        break;
      case 'Debug 1':
        Flame.device.setPortrait();
        
        // SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitDown,
        //   DeviceOrientation.portraitUp,
        // ]);
        break;
      
    }
  }
}





