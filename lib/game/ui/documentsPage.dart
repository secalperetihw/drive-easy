import 'package:drive_easy/documents/About_The_Game.dart';
import 'package:drive_easy/documents/Actual_Process.dart';
import 'package:drive_easy/documents/Authorization_Whats_important.dart';
import 'package:drive_easy/documents/Cloud_Computing.dart';
import 'package:drive_easy/documents/Cloud_Storage.dart';
import 'package:drive_easy/documents/Filtering.dart';
import 'package:drive_easy/documents/OAuth2.dart';
import 'package:drive_easy/documents/Problem_with_OAuth2_and_SSO.dart';
import 'package:drive_easy/documents/REST_API.dart';
import 'package:drive_easy/documents/Relation_between_action_and_reqtype.dart';
import 'package:drive_easy/documents/SSL_TLS.dart';
import 'package:drive_easy/documents/SSO.dart';
import 'package:drive_easy/documents/Third_Party_Application.dart';
import 'package:drive_easy/documents/What_is_Authoriaztion.dart';
import 'package:drive_easy/documents/What_is_Encryption.dart';
import 'package:drive_easy/documents/What_is_POST_GET.dart';
import 'package:drive_easy/documents/Why_correct_info_important.dart';
import 'package:flutter/material.dart';

class DocumentsPage extends StatefulWidget {
  double contentHeight;
  double contentWidth;

  DocumentsPage({ 
    Key? key,
    required this.contentHeight,
    required this.contentWidth,
  }) : super(key: key);

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  Function onpress(int page) {
    return () => setState(() {
      _page = page;
      if (_page < 0) _page = 0;
      pageController.animateToPage(_page, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  Widget cover({required List<Widget> children}) {
    return Container(
      height: widget.contentHeight,
      width: widget.contentWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Stack(
        children: [
          PageView(
            // physics: NeverScrollableScrollPhysics(),
            // allowImplicitScrolling: true,
            onPageChanged: (value) {
              setState(() {
                _page = value;
              });
            },
            controller: pageController,
            children: children,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _page--;
                if (_page < 0) _page = 0;
                pageController.animateToPage(_page, duration: Duration(milliseconds: 500), curve: Curves.ease);
              });
            }, 
            icon: Icon(Icons.arrow_back)
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return cover(children: [
      About_The_Game(onpress: onpress(1)),

      Cloud_Storage(onpress: onpress(2)),

      Third_Party_Application(onpress: onpress(3)),

      Why_correct_info_important(onpress: onpress(4)),
      
      What_is_POST_GET(onpress: onpress(5)),
      
      What_is_Encryption(
        width: widget.contentWidth,
        onpress: onpress(6)
      ),

      Relation_between_action_and_reqtype(onpress: onpress(7)),

      What_is_Authorization(onpress: onpress(8)),

      Authorization_Whats_important(onpress: onpress(9)),

      OAuth2(onpress: onpress(10)),

      SSO(onpress: onpress(11)),

      Problem_with_OAuth2_and_SSO(onpress: onpress(12)),

      Actual_Process(onpress: onpress(13)),

      Filtering(onpress: onpress(14)),

      SSL_TLS(onpress: onpress(15)),

      REST_API(onpress: onpress(16)),

      Cloud_Computing(onpress: onpress(17)),
    ]);
  }
}