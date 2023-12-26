import 'package:flutter/material.dart';

import '../services/MangadexLib.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
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
    return FutureBuilder(
      future: state,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Image.network(pages[index]);
              });
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
    );
  }
}
