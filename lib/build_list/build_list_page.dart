import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lol_build/add_build/add_build_page.dart';
import 'package:lol_build/domain/build.dart';
import 'package:lol_build/edit_build/edit_build_page.dart';
import 'package:provider/provider.dart';
import 'build_list_model.dart';

class BuildListPage extends StatelessWidget {

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
                  (builds) => Slidable(
                    actionExtentRatio: 0.2,
                    actionPane: SlidableScrollActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        caption: '編集',
                        color: Colors.black45,
                        icon: Icons.edit,
                        onTap: () async {
                          final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditBuildPage(builds),
                            ),
                          );
                          if (title != null) {
                            final snackBar = SnackBar(
                              content: Text('$titleを編集しました'),
                              backgroundColor: Colors.green,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          };
                          model.fetchBuildList();
                        },
                      ),
                      IconSlideAction(
                        caption: '削除',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {
                          await showConfirmDialog(context, builds, model);
                        },
                      ),
                    ],
                    child: ListTile(
                      title: Text(builds.title),
                      subtitle: Text(builds.memo),
                    ),
                  ),
            )
           .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: Consumer<BuildListModel>(builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: () async {
                final bool? added = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddBuildPage(),
                        fullscreenDialog: true,
                    ),
                );
                if (added != null && added) {
                  final snackBar = SnackBar(
                    content: Text('ビルドを追加しました'),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                };
                model.fetchBuildList();
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            );
          }
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
  Future showConfirmDialog(BuildContext context, Build builds, BuildListModel model) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("『${builds.title}』を削除しますか？"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () async{
                await model.delete(builds);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  content: Text('${builds.title}を削除しました'),
                  backgroundColor: Colors.red,
                );
                model.fetchBuildList();
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
