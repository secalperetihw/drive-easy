import 'package:flutter/cupertino.dart';
import 'package:googleapis/bigquery/v2.dart';
import 'package:googleapis/drive/v3.dart';

abstract class Drive_data{
  @protected
  String? account_name;
  String? get getaccount => account_name;

  @protected
  int? capacity;
  int? get getCapacity => capacity;

  @protected
  int? used;
  int? get getUsed => used;

  @protected
  int? left;
  int? get getLeft => left;
  
  @protected
  var status;
  dynamic get getStatus => status;

  @protected
  var data;
  dynamic get getData => data;
  set setData(var data) => data = data;

  Drive_data({
    String? account,
    int? capacity,
    int? used,
    int? left,
    var status
  });

  Map<dynamic,dynamic> toJson();

  Future upload({required driveApi, required context});

  Future download({required driveApi, required context});

  Future transfer({required driveApi, required context, required Drive_data destination});

  Future getFileList({required driveApi, required context});
}