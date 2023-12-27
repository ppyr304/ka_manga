import 'dart:developer';

import 'package:mangadex_library/mangadex_library.dart';

Future<String> fetchCoverArt(String id) async {
  String coverArt = '';

  var client = MangadexClient(
    refreshDuration: const Duration(minutes: 1),
    onRefresh: () {
      log('Token refreshed!');
    },
  );

  try {
    var mangaID = [id];
    Cover cover = await client.getCoverArt(mangaID);
    print('-----');
    print(mangaID[0]);
    print(cover.data![0].attributes!.fileName);

    coverArt = '${mangaID[0]}/${cover.data![0].attributes!.fileName}';
  } on MangadexServerException catch (error) {
    for (var error in error.info.errors!) {
      log('at fetchCoverArt');
      log(error.title!);
      log(error.detail!);
    }
  }
  client.dispose();
  return coverArt;
}
