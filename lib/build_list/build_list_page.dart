import 'package:flutter/material.dart';
import 'package:lol_build/domain/build.dart';
import 'package:provider/provider.dart';
import 'build_list_model.dart';

class BuildListPage extends StatelessWidget {
  BuildListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BuildListModel>(
      create: (_) => BuildListModel()..fetchBuildList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LOLビルド'),
        ),
        body: Center(
          child: Consumer<BuildListModel>(builder: (context, model, child) {
            final List<Build>? builds = model.builds;

            if (builds == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = builds
                .map(
                  (build) => ListTile(
                    title: Text(build.title),
                    subtitle: Text(build.memo),
                  ),
            )
           .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
