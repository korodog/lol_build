import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lol_build/domain/build.dart';

class BuildListModel extends ChangeNotifier {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('builds').snapshots();
  List<Build>? builds;

  void fetchBuildList() {
    _usersStream.listen((QuerySnapshot snapshot) {
      final List<Build> builds = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String title = data['title'];
        final String memo = data['memo'];
        return Build(title, memo);
      }).toList();
      this.builds = builds;
      notifyListeners();
    });
  }
}