import 'package:drive_easy/global.dart';
import 'package:drive_easy/ui/widget/google_drive_block.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget testing = const Text('123');
  Map<String, GlobalKey> globalKeyList = {
    'googleDirveBlock': GlobalKey(debugLabel: "googleDirveBlock")
  };

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
        });
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              googleDirveBlock(
                key: globalKeyList['googleDirveBlock'],
                testing: testing,
              ),
              
            ],
          )
        ],
      ),
    );
  }
}