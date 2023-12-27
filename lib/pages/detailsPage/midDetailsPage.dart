import 'package:flutter/material.dart';
import 'package:ka_manga/entities/constant.dart';

import '../../entities/mangaData.dart';

class MidDetailPage extends StatefulWidget {
  const MidDetailPage({super.key, required this.data});

  final MangaData data;

  @override
  State<MidDetailPage> createState() => _MidDetailPageState();
}

class _MidDetailPageState extends State<MidDetailPage> {

  @override
  void initState() {
    print('-- ${widget.data}');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                widget.data.mangaData!.title!.en!,
                style: const TextStyle(fontSize: 24),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('status : ${widget.data.mangaData!.status}'),
                  Text(
                      'last update : ${formatDate(widget.data.mangaData!.updatedAt!)}'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text('description :'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                widget.data.mangaData!.description!.en!,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
