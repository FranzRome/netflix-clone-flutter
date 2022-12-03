import 'package:exam_project/views/tv_show/tv_show_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
  late final Future<TvShowEntity> tvShow;

  @override
  void initState() {
    tvShow = _tvShowBloc.fetchTvShowById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tv Show Detail'),
        ),
        body: FutureBuilder<TvShowEntity>(
          future: _tvShowBloc.fetchTvShowById(widget.id),
          builder:
              (BuildContext context, AsyncSnapshot<TvShowEntity> snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final TvShowEntity data = snapshot.data!;

            String genres = '';
            for (String s in data.genres) {
              genres += ' ';
              genres += s;
            }

            return SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 5.0),
                    child: Column(children: [
                      Text(
                        data.title,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      //Spacer(),
                      Padding(
                          padding: const EdgeInsets.all(30),
                          child: Image.network(data.image)),
                      Text('Genres: $genres'),
                      //TODO show all genres instead of only the first one
                      //Spacer(),
                      Text('Rating: ${data.rating}, Status: ${data.status}'),
                      Html(data: data.description)
                    ])));
          },
        ));
  }
}
