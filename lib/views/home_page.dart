import 'package:exam_project/entities/tv_show_entity.dart';
import 'package:exam_project/views/detail_page.dart';
import 'package:exam_project/views/tv_show/tv_show_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HomePage extends StatefulWidget {
  static const route = "/home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TvShowBloc _tvShowBloc = TvShowBloc();

  @override
  void initState() {
    _tvShowBloc.getTvShows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home'),),
        body: FutureBuilder<List<TvShowEntity>>(
          future: _tvShowBloc.getTvShows(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TvShowEntity>> snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final List<TvShowEntity> data = snapshot.data!;
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  TvShowEntity element = data[index];
                  return Card(
                      child: ListTile(
                    leading: Image.network(element.image),
                    title: Text(element.title),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      element.rating != null
                          ? Text("Rating: ${element.rating!}")
                          : Text("Not rated\n${element.description}"),
                      Html(data: element.description.replaceAll('\n', '').replaceRange(62, element.description.length, '...'))
                    ]),
                    trailing: const Icon(Icons.more_vert),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(id: element.id)))
                    },
                  ));
                });
          },
        ));
  }
}
