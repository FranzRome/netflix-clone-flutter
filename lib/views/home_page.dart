import 'package:exam_project/entities/tv_show_entity.dart';
import 'package:exam_project/views/detail_page.dart';
import 'package:exam_project/views/tv_show/tv_show_bloc.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(),
        body: FutureBuilder<List<TvShowEntity>>(
          future: _tvShowBloc.getTvShows(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TvShowEntity>> snapshot) {
            if (snapshot.data == null) {
              return const CircularProgressIndicator();
            }
            final List<TvShowEntity> data = snapshot.data!;
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                    leading: Image.network(data[index].image!),
                    title: Text(data[index].title!),
                    subtitle: Text("Rating: ${data[index].rating!}"),
                    trailing: const Icon(Icons.more_vert),
                        onTap: () => {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailPage(id: data[index].id)))
                      },
                  ));
                });
          },
        ));
  }
}
