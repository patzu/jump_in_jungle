import 'package:flutter/material.dart';
import 'package:jungler/delete_me/main_test.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Union union = Union.loading();
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          Future.delayed(Duration(seconds: 5), () {
            union = Union.data(32);
          });
          print(
            union.when(
              data: (data) => print('data ${data}'),
              loading: () => print('loading'),
              error: (error) => print('Error ${error}'),
            ),
          );
        },
      ),
    );
  }
}
