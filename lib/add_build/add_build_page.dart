import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_build_model.dart';

class AddBuildPage extends StatelessWidget {
  const AddBuildPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBuildModel>(
      create: (_) => AddBuildModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ビルド作成'),
        ),
        body: Center(
          child: Consumer<AddBuildModel>(builder: (context, model, child) {
            return Column(children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'ビルド名',
                ),
                onChanged: (text) {
                  model.title = text;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                  decoration: const InputDecoration(
              hintText: 'ビルドメモ',
                  ),
                onChanged: (text) {
                    model.memo = text;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(onPressed: () async {
                try {
                 await model.addBuild();
                 Navigator.of(context).pop(true);
                } catch (e) {
                  final snackBar = SnackBar(
                    content: Text(e.toString()),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                }, child: const Text('作成'),
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
