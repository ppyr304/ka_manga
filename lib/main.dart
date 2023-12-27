import 'package:flutter/material.dart';
import 'package:ka_manga/services/MangadexLib.dart';
import 'package:ka_manga/pages/searchPage.dart';

import 'entities/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ka Manga',
      theme: CustomTheme(),
      home: const MyHomePage(title: 'Ka Manga'),
      // home: const DetailsPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String>? state;
  List<String> pages = [];

  Future<void> test() async {
    pages = await MangadexLib.printFilenames();
    setState(() {
      state = Future.value('done');
    });
  }

  @override
  void initState() {
    test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu_book)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Container(),
    );
  }
}
