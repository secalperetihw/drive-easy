import 'dart:async';
import 'dart:ui' as ui;

import 'package:drive_easy/classes/game/item.dart';
import 'package:drive_easy/classes/game/progress.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/game/ui/requestPage/requestClasses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:overlay_tutorial/overlay_tutorial.dart';

class modifyPage extends StatefulWidget {
  modifyPage({ 
    Key? key,
    this.game,
    this.scrollOffset,
    required this.item,
    required this.contentHeight,
    required this.contentWidth,
    required this.progress,
    required this.callback,
    required this.isTutorialEnabled,
    required this.isTutorialOn,
    required this.tutorialOverlaysEntries,
  }) : super(key: key);

  final GameMain? game;
  Item item;
  double contentWidth;
  double contentHeight;
  Progress progress;
  ValueChanged<Map<String, dynamic>> callback;
  double? scrollOffset;
  bool isTutorialEnabled;
  List<bool> isTutorialOn;
  List<OverlayTutorialRectEntry> tutorialOverlaysEntries;

  @override
  _modifyPageState createState() => _modifyPageState();
}

class _modifyPageState extends State<modifyPage> with AutomaticKeepAliveClientMixin<modifyPage>{
  String text = "";
  int selected = 0;
  late CustomTextPainter textPainter;
  late CustomTextPainter textPainter2;
  int textLength = 0;
  Widget wrap = Container();
  HtmlEditorController htmlEditorController = HtmlEditorController();
  int viewSize = 10;
  List<String> input = [];
  List<bool> onhover = [];
  List<bool> ontap = [];
  Size size = Size.zero;
  Size size2 = Size.zero;
  late CustomPaint customPaint;
  double textOffset = 0.1;

  bool update = false;

  var key = GlobalKey();  

  @override
  void initState() {
    super.initState();

    input = (widget.item.finish == true) ? widget.item.getOriginContent.split(" ") : widget.item.content!.split(" ");
    for (int i=0; i< input.length; i++) {
      onhover.add(false);
      ontap.add(false);
    }
  }
  String intFixed(int n, int count) => n.toString().padLeft(count, "0");

  @override
  void dispose() {
    super.dispose();
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    textOffset = widget.progress.textOffset ?? 0.17;

    return Container(
      width: widget.contentWidth,
      height: widget.contentHeight,
      padding: EdgeInsets.all(25),
      color: Colors.black,
      child: Wrap(
        children: [
          Container(
            height: widget.contentHeight * 0.8,
            width: widget.contentWidth * 0.75,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: OverlayTutorialHole(
                enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[18] : false,
                overlayTutorialEntry: widget.tutorialOverlaysEntries[19],
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: input.map((e) {
                    double width = widget.contentWidth * textOffset;
                  
                    textPainter = CustomTextPainter(
                      text: e,
                      tutorialStyle: (widget.isTutorialEnabled == true && widget.item.maliciousPosition![input.indexOf(e)] != null && widget.isTutorialOn[18]) ? true : false,
                      maxWidth: width,
                    );
                    textPainter.paint(Canvas(ui.PictureRecorder()), size);
                    Offset offset = textPainter.returnOffset();
                    size = Size(offset.dx, offset.dy);
                  
                    String s = "";
                    input[input.indexOf(e)].codeUnits.forEach((element) { 
                      s += element.toRadixString(16).padLeft(2, "0") + " ";
                    });
                    String text2 = s;
                    textPainter2 = CustomTextPainter(
                      text: text2,
                      maxWidth: width * 3,
                    );
                    textPainter2.paint(Canvas(ui.PictureRecorder()), size);
                    Offset offset2 = textPainter.returnOffset();
                    size2 = Size(offset2.dx, offset2.dy);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text( intFixed(input.indexOf(e), 2).toString(), style: TextStyle(color: Colors.white),)
                        ),
                  
                        Container(
                          width: width * 3,
                          color: (onhover[input.indexOf(e)] || ontap[input.indexOf(e)]) 
                            ? Colors.grey 
                            : Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                ontap.forEach((element) {ontap[ontap.indexOf(element)] = false;});
                  
                                ontap[input.indexOf(e)] = true;
                              });
                            },
                            child: MouseRegion(
                              onEnter: (details) => setState(() => onhover[input.indexOf(e)] = true),
                              onExit: (details) => setState(() => onhover[input.indexOf(e)] = false),
                              child: CustomPaint(
                                size: size2,
                                painter: textPainter2,
                              )
                            ),
                          ),
                        ),
                  
                        Container(
                          // key: (widget.isTutorialEnabled == true && widget.item.maliciousPosition![input.indexOf(e)] != null && widget.isTutorialOn[18]) ? key : null,
                          width: width,
                          color: (onhover[input.indexOf(e)] || ontap[input.indexOf(e)]) 
                            ? Colors.grey 
                            : (widget.item.finish == true && widget.item.maliciousPosition![input.indexOf(e)] != null) 
                              ? Colors.red
                              : Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                ontap.forEach((element) {ontap[ontap.indexOf(element)] = false;});
                  
                                ontap[input.indexOf(e)] = true;
                                text = e;
                              });
                            },
                            child: MouseRegion(
                              onEnter: (details) => setState(() => onhover[input.indexOf(e)] = true),
                              onExit: (details) => setState(() => onhover[input.indexOf(e)] = false),
                              child: CustomPaint(
                                size: size,
                                painter: textPainter,
                              )
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Container(
            width: widget.contentWidth * 0.15,
            height: widget.contentHeight * 0.8,
            alignment: Alignment.center,
            child: (widget.item.finish ?? false) ? Container() : Column(
              // alignment: WrapAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: widget.contentWidth * 0.4,
                  child: Text(
                    "Functions:",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.15,
                  height: widget.contentHeight * 0.08,
                  onPressed: (value){
                    if (widget.item.encrypted == false) {
                      setState(() {
                        widget.item.encrypted = true;
                      });
                      final key = encrypt.Key.fromUtf8(widget.item.key!);
                      widget.item.encrypter = encrypt.Encrypter(encrypt.AES(key));
                      widget.item.encryptedContent = widget.item.encrypter!.encrypt(widget.item.content!, iv:widget.item.iv);
                      setState(() {
                        widget.item.content = widget.item.encryptedContent!.base64;
                        widget.callback({"item": widget.item});
                        input = [widget.item.content!];
                      });
                      
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("You have already encrypted."),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () { },
                        ),
                      ));
                      return;
                    }
                  },
                  text: "Encrypt",
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.15,
                  height: widget.contentHeight * 0.08,
                  onPressed: (value){
                    if (widget.item.encrypted == true) {
                      setState(() {
                        widget.item.encrypted = false;
                      });
                      final key = encrypt.Key.fromUtf8(widget.item.key!);
                      setState(() {
                        widget.item.content = "";
                        if (widget.item.wrappedAfterEncrpyt == true) {
                          widget.item.wrappedAfterEncrpyt = false;
                          for (int i=0; i<14; i++) {
                            widget.item.content = widget.item.content! + input[i] + " ";
                            print("input: ${input[i]}");
                          }
                          
                        }
                        widget.item.content = widget.item.content! + widget.item.encrypter!.decrypt(widget.item.encryptedContent!, iv:widget.item.iv);
    
                        input = widget.item.content!.split(" ");
                        onhover = [];
                        ontap = [];
                        for (int i=0; i< input.length; i++) {
                          onhover.add(false);
                          ontap.add(false);
                        }
                        
                        widget.callback({"item": widget.item});
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("You have already decrypted."),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () { },
                        ),
                      ));
                      return;
                    }
                  },
                  text: "Decrypt",
                ),
                OverlayTutorialHole(
                  enabled: (widget.isTutorialEnabled) ? widget.isTutorialOn[18] : false,
                  overlayTutorialEntry: widget.tutorialOverlaysEntries[20],
                  child: requestPageButton(
                    width: widget.contentWidth * 0.15,
                    height: widget.contentHeight * 0.08,
                    onPressed: (value){
                      if (widget.isTutorialEnabled && widget.isTutorialOn[18]) {
                        setState(() {
                          widget.isTutorialOn[18] = false;
                          widget.isTutorialOn[19] = true;
                          // widget.isTutorialEnabled = false;
                          widget.callback({"isTutorialOn" : widget.isTutorialOn});
                        });
                      }

                      if (widget.item.encrypted == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("You can't filter after encrypted."),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () { },
                          ),
                        ));
                        return;
                      }
                      if (widget.item.wrapped == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("You should filter before wrap."),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () { },
                          ),
                        ));
                        return;
                      }
                    
                      setState(() {
                        if (ontap.indexOf(true) == -1) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text("You haven't chosen line yet."),
                            duration: const Duration(seconds: 3),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () { },
                            ),
                          ));
                          return;
                        }
                        String s = input[ontap.indexOf(true)];
                        int index = ontap.indexOf(true) - ((widget.item.wrapped == true) ? 14 : 0);
                        if (widget.item.maliciousPosition![index] ?? false) {
                          s = s.replaceAll("function", "\"function\"");
                          s = s.replaceAll("execute", "\"execute\"");
                          s = s.replaceAll("(", "\\(");
                          s = s.replaceAll(")", "\\)");
                          s = s.replaceAll("{", "\\{");
                          s = s.replaceAll("}", "\\}");
                          s = s.replaceAll(":", "\\:");
                          s = s.replaceAll(";", "\\;");
                    
                          widget.item.maliciousPosition![index] = false;
                          if(input[ontap.indexOf(true)].contains("**")) widget.item.score = widget.item.score! + 1;
                        } else {
                          s = s.replaceAll("\"function\"", "function");
                          s = s.replaceAll("\"execute\"", "execute");
                          s = s.replaceAll("\\(", "(");
                          s = s.replaceAll("\\)", ")");
                          s = s.replaceAll("\\{", "{");
                          s = s.replaceAll("\\}", "}");
                          s = s.replaceAll("\\:", ":");
                          s = s.replaceAll("\\;", ";");
                    
                          widget.item.maliciousPosition![index] = true;
                          if(input[ontap.indexOf(true)].contains("**")) widget.item.score = widget.item.score! - 1;
                        }
                    
                        input[ontap.indexOf(true)] = s;
                    
                        widget.item.content = "";
                        for (int i= 0; i<input.length; i++) {
                          widget.item.content = widget.item.content! + input[i] + " ";
                        }
                    
                        text = input[ontap.indexOf(true)];
                        widget.callback({"item": widget.item});
                    
                        print(widget.item.score);
                      });
                    },
                    text: "Filter",
                  ),
                ),
                requestPageButton(
                  width: widget.contentWidth * 0.15,
                  height: widget.contentHeight * 0.08,
                  onPressed: (value) async {
                    if (widget.item.wrapped == true) {
                      setState(() {
                        widget.item.content = "";
                        for (int i=14; i<input.length; i++) {
                          widget.item.content = widget.item.content! + input[i] + " ";
                        }
                        input = widget.item.content!.split(" ");
                        onhover = [];
                        ontap = [];
    
                        for (int i=0; i< input.length; i++) {
                          onhover.add(false);
                          ontap.add(false);
                        }
    
                        widget.item.wrapped = false;
                        widget.callback({"item": widget.item});
                      });
                      return;
                    }
                    bool exit = false;
                    await showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) { 
                      
                        return AlertDialog(
                          title: Text("Wrap with HTTP request"),
                          content: Text("Are you sure to wrap?\nPlease make sure you filter all malicious code before you wrap.", style: TextStyle(color: Colors.red),),
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
                    if(!exit) return;
    
                    setState(() {
                      
                      String s = "";
    
    
                      s += "${Item.convert(widget.item.action)}\thttps://${widget.item.destination}/api/${Item.convert(widget.item.reqType)}/DriveEasy\tHTTPS "
                      + "Host:\tcom.forpersonaluse.drive_easy "
                      + "Token:\t" + Item.randomStringGenerator(length: 16, pool: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") + " "
                      + "User-Agent:\tdrive-easy\t(gzip) "
                      + "Accept:\ttext/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8 "
                      + "Accept-Language:\ten-us,en;q=0.5 "
                      + "Accept-Encoding:\tgzip,deflate "
                      + "Accept-Charset:\tISO-8859-1,utf-8;q=0.7,*;q=0.7 "
                      + "Keep-Alive:\t300 "
                      + "Connection:\tkeep-alive "
                      + "Cookie:\tPHPSESSID=r2t5uvjq435r4q7ib3vtdjq120 "
                      + "Pragma:\tno-cache "
                      + "Cache-Control:\tno-cache "
                      + "Content:\t ";
                      s += widget.item.content!;
    
                      setState(() {
                        widget.item.content = s;
                        input = widget.item.content!.split(" ");
                        onhover = [];
                        ontap = [];
    
                        for (int i=0; i< input.length; i++) {
                          onhover.add(false);
                          ontap.add(false);
                        }
    
                        if (widget.item.encrypted == true) widget.item.wrappedAfterEncrpyt = true;
                        widget.item.content = s + widget.item.content!;
                        widget.item.wrapped = true;
                        widget.callback({"item": widget.item});
                      });
                    
                    });
                  },
                  text: "Wrap",
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  requestPageButton(
                    width: widget.contentWidth * 0.15 / 3,
                    height: widget.contentHeight * 0.08,
                    onPressed: (value){
                      setState(() {
                        if (textOffset <= 0.17) textOffset += 0.01;
    
                        widget.progress.textOffset = textOffset;
                        widget.callback({"progress": widget.progress});
                      });
                    },
                    text: "+",
                  ),
                  requestPageButton(
                    width: widget.contentWidth * 0.15 / 3,
                    height: widget.contentHeight * 0.08,
                    onPressed: (value){
                      setState(() {
                        if (textOffset >= 0.05) textOffset -= 0.01;
    
                        widget.progress.textOffset = textOffset;
                        widget.callback({"progress": widget.progress});
                      });
                    },
                    text: "-",
                  ),
                ],)
                
              ],
            ),
          ),
          Container(
            width: widget.contentWidth,
            padding: EdgeInsets.all(5),
            child: RichText(
              softWrap: false,
              overflow: TextOverflow.fade,
              text: TextSpan(
                style: TextStyle(color: Colors.white),
                
                children:[
                  TextSpan(text: widget.item.source.toString().split(".")[1] + 
                  "\\DriveEasy\\" + widget.item.name.toString() + "\\>" + text.replaceAll(" ", "") + "_", )
                ]
                
                
              ),
            ),
          )
        ],
      )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class on9 extends StatelessWidget {
  on9({
    Key? key,
    required this.width,
    required this.onhover,
    required this.input,
    required this.ontap,
    required this.size,
    required this.textPainter,
    required this.item,
    required this.e,
    required this.isTutorialEnabled,
    required this.isTutorialOn,
    required this.tutorialOverlaysEntries,
    required this.gestureDectorOnTap,
    required this.onEnter,
    required this.onExit,
  }) : super(key: key);

  final double width;
  final List<bool> onhover;
  final List<String> input;
  final List<bool> ontap;
  final ui.Size size;
  final CustomTextPainter textPainter;
  final Item item;
  final String e;
  final bool isTutorialEnabled;
  final List<bool> isTutorialOn;
  final tutorialOverlaysEntries;
  final Function gestureDectorOnTap;
  final Function onEnter;
  final Function onExit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: (onhover[input.indexOf(e)] || ontap[input.indexOf(e)]) 
        ? Colors.grey 
        : (item.finish == true && item.maliciousPosition![input.indexOf(e)] != null) 
          ? Colors.red
          : Colors.transparent,
      child: (isTutorialEnabled == true && item.maliciousPosition![input.indexOf(e)] != null && isTutorialOn[18]) 
      ? OverlayTutorialHole(
        
        enabled: (isTutorialEnabled) ? isTutorialOn[18] : false,
        overlayTutorialEntry: tutorialOverlaysEntries[19],
        child: GestureDetector(
          onTap: () {
            gestureDectorOnTap();
          },
          child: MouseRegion(
            onEnter: (details) => onEnter(),
            onExit: (details) => onExit(),
            child: CustomPaint(
              size: size,
              painter: textPainter,
            )
          ),
        ),
      )
      
      : GestureDetector(
        onTap: () {
          gestureDectorOnTap();
        },
        child: MouseRegion(
          onEnter: (details) => onEnter(),
          onExit: (details) => onExit(),
          child: CustomPaint(
            size: size,
            painter: textPainter,
          )
        ),
      ),
    );
  }
}

class CustomTextPainter extends CustomPainter { 
  String text;
  double maxWidth;
  // ValueChanged<int> lengthCallback;
  int? numberOfLines;
  Offset? offset;
  bool? chosen = false;
  bool? tutorialStyle;

  CustomTextPainter({
    required this.text,
    required this.maxWidth,
    this.chosen,
    this.tutorialStyle,
    // required this.lengthCallback,
  });

  @override
  void paint(Canvas canvas, Size size) {

    final textStyle = TextStyle(
      color: (tutorialStyle ?? false) ? Colors.red : Colors.white,
      fontSize: 12,
    );

    var previous;
    int line = 0;
    double dx = 0;
    double last = 0;
    int i=0;
    Offset _offset = Offset.zero;

    for (i; i<text.length; i++) {
      // if (i % (viewSize ?? 10) == 0 && i != 0) line++;
      if (previous != null) {
        _offset = Offset((previous as TextPainter).size.height * dx, previous.size.height * line);
      }
      

      if (_offset.dx > maxWidth) {
        if(text[i] == " ") continue;
        // if(text[i] != " " && text[i-1] != " ") continue;
        line++;
        dx = 0;
        _offset = Offset(0, previous.size.height * line);
      }

      TextSpan textSpan = TextSpan(
        text: text[i],
        style: textStyle,
      );
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start
      );
      textPainter.layout(
        minWidth: maxWidth,
        maxWidth: maxWidth,
      );
      textPainter.paint(
        canvas, 
        (previous != null)
        ? _offset
        : 
        Offset.zero
      );

      previous = textPainter;
      dx++;

      if (i == text.length - 1) {
        last = textPainter.size.height;
      }
    }
    line++;
    offset = Offset(0, last * line);
    
    numberOfLines = line;
  }
  
  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }

  int returnNum() {
    return numberOfLines ?? 0;
  }

  Offset returnOffset() {
    return offset ?? Offset.zero;
  }
}