import 'dart:developer';

import 'package:mangadex_library/mangadex_library.dart';

import '../entities/mangaData.dart';

Future<List<MangaData>> searchManga(String query) async {
  List<MangaData> results = [];

  var client = MangadexClient(
    refreshDuration: const Duration(minutes: 1),
    onRefresh: () {
      log('Token refreshed!');
    },
  );

  try {
    Search searchData = await client.search(query: query);

    for (var data in searchData.data!) {
      results.add(MangaData(data));
    }


  } on MangadexServerException catch (error) {
    for (var error in error.info.errors!) {
      log(error.title!);
      log(error.detail!);
    }
  }
  client.dispose();

  return results;
}
