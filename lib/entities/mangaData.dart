
import 'package:mangadex_library/mangadex_library.dart';

class MangaData{
  String id = '';
  Attributes? mangaData;

  MangaData(SearchData data) {
    id = data.id!;
    mangaData = data.attributes;
  }
}