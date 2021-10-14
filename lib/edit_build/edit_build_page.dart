import 'package:flutter/material.dart';
import 'package:lol_build/domain/build.dart';
import 'package:provider/provider.dart';
import 'edit_build_model.dart';

class EditBuildPage extends StatelessWidget {
  final Build builds;
  EditBuildPage(this.builds);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBuildModel>(
      create: (_) => EditBuildModel(builds),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ビルド編集'),
        ),
        body: Center(
          child: Consumer<EditBuildModel>(builder: (context, model, child) {
            return Column(children: [
              TextField(
                controller: model.titleController,
                decoration: const InputDecoration(
                  hintText: 'ビルド名',
                ),
                onChanged: (text) {
                  model.title = text;
                  model.setTitle(text);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: model.memoController,
                decoration: const InputDecoration(
                  hintText: 'ビルドメモ',
                ),
                onChanged: (text) {
                  model.memo = text;
                  model.setMemo(text);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: model.isUpdated()
                    ? () async {
                try {
                  await model.editBuild();
                  Navigator.of(context).pop(model.title);
                } catch (e) {
                  final snackBar = SnackBar(
                    content: Text(e.toString()),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                } : null,
                child: const Text('更新'),
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
