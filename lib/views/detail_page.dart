import 'package:exam_project/views/tv_show/tv_show_bloc.dart';
import 'package:flutter/material.dart';

import '../entities/tv_show_entity.dart';

class DetailPage extends StatefulWidget {
  static const route = "/detail_page";
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  final TvShowBloc _tvShowBloc = TvShowBloc();
  late final Future<TvShowEntity> tvShow ;

  @override
  void initState() {
    tvShow = _tvShowBloc.fetchTvShowById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<TvShowEntity>(
          future: _tvShowBloc.fetchTvShowById(widget.id),
          builder: (BuildContext context,
              AsyncSnapshot<TvShowEntity> snapshot) {
            if (snapshot.data == null) {
              return const CircularProgressIndicator();
            }
            final TvShowEntity data = snapshot.data!;
            return Container(
                child:
                Column(
                    children: [Text(data.title), Text(data.description)]));
          },
        ));
  }
}
