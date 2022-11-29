import 'package:exam_project/views/tv_show/tv_show_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const route = "/home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TvShowBloc _tvShowBloc = TvShowBloc();

  @override
  void initState() {
    _tvShowBloc.getTvShows();
    print('Hello');
    print(_tvShowBloc.showsList);
    super.initState();
  }

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(

      ),
    );
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
