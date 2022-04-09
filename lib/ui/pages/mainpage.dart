import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/game/ui/computerPage.dart';
import 'package:drive_easy/game/ui/requestPage/request.dart';
import 'package:drive_easy/ui/pages/home.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  MainPage({
    required this.game,
    Key? key
  }) : super(key: key);

  GameMain game;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget page = const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Functions'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  page = const HomePage();
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text('Games'),
              onTap: () {
                Navigator.pop(context);
                
                // SystemChrome.setPreferredOrientations([
                //   DeviceOrientation.landscapeLeft,
                //   DeviceOrientation.landscapeRight
                // ]).then((_) async {
                  // BuildContext? dismiss;
                  // showDialog<void>(
                  //   context: context,
                  //   barrierDismissible: false,
                  //   builder: (BuildContext ctx) { 
                      
                  //     dismiss = ctx;
                  //     return Center(child: CircularProgressIndicator(),);
                  //   }
                  // );
                  // await Future.delayed(Duration(milliseconds: 500));
                  // Navigator.pop(dismiss!);
            
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => GameMainWithOverlays()));
                  setState(() {
                  });
                // });
              },
            ),
            ListTile(
              title: const Text('Linked Devices'),
              onTap: () {
                setState(() {
                  page = Container();
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                setState(() {
                  page = Container();
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text("debug"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => ComputerMainPage()));
              }
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Drive Easy'),
      ),
      body: page,
    );
  }
}


