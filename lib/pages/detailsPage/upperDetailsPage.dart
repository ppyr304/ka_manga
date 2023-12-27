import 'package:flutter/material.dart';
import 'package:ka_manga/entities/constant.dart';
import 'package:ka_manga/entities/mangaData.dart';
import 'package:ka_manga/pages/detailsPage/midDetailsPage.dart';
import 'package:ka_manga/services/fetchInfo.dart';
import 'package:mangadex_library/mangadex_library.dart';

class UpperDetailsPage extends StatefulWidget {
  const UpperDetailsPage({super.key, required this.data});

  final MangaData data;

  @override
  State<UpperDetailsPage> createState() => _UpperDetailsPageState();
}

class _UpperDetailsPageState extends State<UpperDetailsPage> {
  Future<String>? state;
  String id = '';
  late Attributes attributes;
  String coverArt = '';

  //for custom scrollview
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

  double _calculateSize(double scrollPosition) {
    double max = 24;
    if (scrollPosition < 80) {
      return max; // Fully visible at scroll position > 100.0
    } else {
      return max / scrollPosition;
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
    int width = (MediaQuery.of(context).size.width / 80).abs().toInt();
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
                  floating: false,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    title: Opacity(
                      opacity: _scrollController.hasClients
                          ? _calculateOpacity(_scrollController.offset)
                          : 0.0,
                      child: Text(
                        widget.data.mangaData!.title!.en!,
                        style: const TextStyle(fontSize: 18),
                        maxLines: 1,
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
                      height: _scrollController.hasClients
                          ? _calculateSize(_scrollController.offset)
                          : 0.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                        ),
                      ),
                    ),
                  ),
                  leadingWidth: 80,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Primary.withOpacity(0.8)),
                    ),
                  ),
                ),
                MidDetailPage(data: widget.data),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'chapters',
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.sort),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 220,
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text('$index'),
                          ),
                        );
                      },
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: width,
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
