import 'dart:async';
import 'package:exam_project/api/tv_show_remote.dart';
import 'package:exam_project/entities/tv_show_entity.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class TvShowBloc {

  List<TvShowEntity> _showsList = List.empty();

  Future<List<TvShowEntity>> getTvShows() async {
    if(_showsList.isEmpty) {
      _showsList = await _fetchTvShowsList();
    }
    return _showsList;
  }

  Future<List<TvShowEntity>> _fetchTvShowsList() async {
    var url = Uri.parse("https://api.tvmaze.com/shows");
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        var responseList = convert.jsonDecode(response.body) as List<dynamic>;

        var remoteList = responseList.map((e) => TvShowRemote.fromJson(e));

        return remoteList.map((e) => e.toEntity()).toList();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load shows');
      }
    }
    catch(e) {
      print(e);
    }

    return List.empty();
  }

  Future<TvShowEntity> fetchTvShowById(String id) async {
    var url = Uri.parse('https://api.tvmaze.com/shows/$id');
    var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = convert.jsonDecode(response.body);
        var remote = TvShowRemote.fromJson(json);
        return remote.toEntity();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load shows');
      }
    }
  }