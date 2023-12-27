import 'package:flutter/material.dart';
import 'package:ka_manga/entities/mangaData.dart';
import 'package:ka_manga/services/fetchInfo.dart';
import 'package:mangadex_library/mangadex_library.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.data});

  final MangaData data;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<String>? state;
  String id = '';
  late Attributes attributes;
  String coverArt = '';

  //for customscrollview
  final _scrollController = ScrollController();

  void fetchCovers() async {
    coverArt = await fetchCoverArt(id);
    state = Future.value('done');
    setState(() {});
  }

  double _calculateOpacity(double scrollPosition) {
    double max = 200;
    if (scrollPosition > max) {
      return 1.0; // Fully visible at scroll position > 100.0
    } else {
      return scrollPosition / max;
      // Gradually become visible as scrolling down
    }
  }

  @override
  void initState() {
    id = widget.data.id;
    attributes = widget.data.mangaData!;
    fetchCovers();
    _scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: state,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Opacity(
                      opacity: _scrollController.hasClients
                          ? _calculateOpacity(_scrollController.offset)
                          : 0.0,
                      child: Text(
                        widget.data.mangaData!.title!.en!,
                        style: const TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    background: Image.network(
                      'https://uploads.mangadex.org/covers/$coverArt',
                      fit: BoxFit.cover,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0.0),
                    child: Container(
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
