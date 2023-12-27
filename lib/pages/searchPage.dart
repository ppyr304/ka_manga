import 'package:flutter/material.dart';
import 'package:ka_manga/pages/detailsPage.dart';

import '../entities/mangaData.dart';
import '../services/search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //text field
  var controller = TextEditingController();
  String query = '';
  //listview
  Future<String>? state;
  List<MangaData> results = [];

  void getSearch() async {
    results = await searchManga(query);
    setState(() {
      state = Future.value('done');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('search'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'mange title',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (text) {
                query = text;
                getSearch();
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: state,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                              Text(results[index].mangaData!.title!.en ?? ''),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  data: results[index],
                                ),
                              ),
                            );
                          },
                        );
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
