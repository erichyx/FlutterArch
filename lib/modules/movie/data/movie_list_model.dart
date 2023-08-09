import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_arch/modules/movie/data/movie_repo.dart';
import 'package:flutter_arch/modules/movie/movie_list_screen.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'movie_list.dart';

class MovieListModel extends ChangeNotifier {
  var _nextLoadPos = 0;
  var _showingMovie = true;
  var _movieSort = MovieSort.recommend;
  final _movieRepo = MovieRepo();
  var _needScrollTop = false;

  bool get firstLoad => _nextLoadPos == 0;
  bool get needScrollTop => _needScrollTop;
  final List<MovieItem> _movieList = <MovieItem>[];

  UnmodifiableListView<MovieItem> get movieList =>
      UnmodifiableListView(_movieList);

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  MovieListModel() {
    onRefresh();
  }

  void onRefresh() {
    _nextLoadPos = 0;
    onLoading();
  }

  void onLoading() {
    _fetchMovieList();
  }

  void movieTypeChange(bool showingMovie) {
    if (_showingMovie != showingMovie) {
      _showingMovie = showingMovie;
      _needScrollTop = true;
      onRefresh();
    }
  }

  void movieSortChange(MovieSort movieSort) {
    if (_movieSort != movieSort) {
      _movieSort = movieSort;
      _needScrollTop = true;
      onRefresh();
    }
  }

  void _fetchMovieList() {
    _needScrollTop = firstLoad;
    _movieRepo
        .fetchMovieList(_showingMovie, _movieSort.name, _nextLoadPos)
        .then((MoviePagingEntity? data) {
      if (refreshController.isRefresh) {
        refreshController.refreshCompleted();
      }

      if (data == null) {
        refreshController.loadFailed();
      } else if (data.items.isNotEmpty) {
        if (firstLoad) {
          _movieList.clear();
        }
        _nextLoadPos += data.items.length;
        _movieList.addAll(data.items);
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }

      notifyListeners();
    });
  }
}
