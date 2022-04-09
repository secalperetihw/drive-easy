// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Blocks extends StatefulWidget {
  Widget? icon;
  String? drive_name;
  String? account_data;
  int? capacity;
  int? used;
  Function? upload;
  Function? browse;
  Function? signout;

  Blocks({
    Key? key,
    this.icon,
    this.drive_name,
    this.account_data,
    this.capacity,
    this.used,
    this.upload,
    this.browse,
    this.signout,
  }) : super(key: key);

  @override
  State<Blocks> createState() => _BlocksState();
}

class _BlocksState extends State<Blocks> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 1,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: widget.icon
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        widget.drive_name ?? '',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        widget.account_data ?? '',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'used: ' 
                        + (double.parse( ((widget.used ?? 0)/1024/1024/1024) .toString())).toStringAsFixed(2) + ' / '
                        + (double.parse( ((widget.capacity ?? 0)/1024/1024/1024) .toString())).toStringAsFixed(2) + ' GB',
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: Text('Upload file'),
                    onPressed: (){

                      (widget.upload ?? (){})();
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: Text('Browse'),
                    onPressed: (){
                      (widget.browse ?? (){})();
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: ()  {
                      (widget.signout ?? (){})();
                    }, 
                    child: const Text("Signout")
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}