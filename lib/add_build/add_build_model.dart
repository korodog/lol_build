import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBuildModel extends ChangeNotifier {
  String? title;
  String? memo;

  Future addBuild() async {
    if (title == null || title == "") {
      throw 'ビルド名が入力されていません';
    }
    if (memo == null || memo == "") {
      throw 'メモが入力されていません';
    }

    await FirebaseFirestore.instance.collection('builds').add({
      'title': title,
      'memo': memo,
    });
  }
}