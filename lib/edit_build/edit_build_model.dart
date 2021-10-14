import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lol_build/domain/build.dart';

class EditBuildModel extends ChangeNotifier {
  final Build builds;
  EditBuildModel(this.builds) {
    titleController.text = builds.title;
    memoController.text = builds.memo;
  }

  final titleController = TextEditingController();
  final memoController = TextEditingController();

  String? title;
  String? memo;

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }
  void setMemo(String memo) {
    this.memo = memo;
    notifyListeners();
  }

  bool isUpdated() {
    return title != null || memo != null;
  }

  Future editBuild() async {
    this.title = titleController.text;
    this.memo = memoController.text;

    await FirebaseFirestore.instance.collection('builds').doc(builds.id).update({
      'title': title,
      'memo': memo,
    });
  }
}