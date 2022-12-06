import 'package:exam_project/entities/tv_show_entity.dart';
import 'package:exam_project/views/detail_page.dart';
import 'package:exam_project/views/tv_show/tv_show_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:exam_project/globals.dart' as globals;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  //TODO Add favorite button to list tile
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
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
                              : const Text('Not rated'),
                          Html(
                              data: element.description
                                  .replaceRange(
                                      62, element.description.length, '...')
                                  .replaceAll('\n', ''))
                        ]),
                    trailing: ValueListenableBuilder<Box>(
                        valueListenable: Hive.box('favorites').listenable(),
                        builder: (context, box, widget) {
                          return (element.favorite == true
                              ? IconButton(
                                  icon: const Icon(Icons.star),
                                  onPressed: () {
                                    globals.setFavorite(element.id, false);
                                    element.favorite = false;
                                    final snackBar = SnackBar(
                                        content: Text(
                                            '${element.title} removed from favorites'),
                                        action: SnackBarAction(
                                            label: 'Undo',
                                            onPressed: () {
                                              globals.setFavorite(
                                                  element.id, true);
                                              element.favorite = true;
                                            }));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(Icons.star_border),
                                  onPressed: () {
                                    globals.setFavorite(element.id, true);
                                    element.favorite = true;
                                    final snackBar = SnackBar(
                                      content: Text(
                                          '${element.title} added to favorites'),
                                      action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            globals.setFavorite(
                                                element.id, false);
                                            element.favorite = false;
                                          }),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }));
                        }),
                    onTap: () => {
                      Navigator.of(context).push(_goToDetail(element.id))
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(id: element.id)))*/
                    },
                  ));
                });
          },
        ));
  }

  Route _goToDetail(String id) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          DetailPage(id: id),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.ease;

        var tween = Tween<double>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        return ScaleTransition(
          scale: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
