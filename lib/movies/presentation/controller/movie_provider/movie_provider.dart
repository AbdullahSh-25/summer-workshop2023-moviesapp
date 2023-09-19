import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/data/repository/movies_repository.dart';

import '../../../data/models/movie_model.dart';

class MovieProvider with ChangeNotifier {
  final List<MovieModel> nowPlayingMovies = [];
  RequestState nowPlayingState = RequestState.initial;
  String nowPlayingErrorMessage = '';

  getNowPlaying() async {
    nowPlayingState = RequestState.loading;
    notifyListeners();
    final result = await MoviesRepository.getNowPlayingMovies();
    result.fold(
      (l) {
        nowPlayingErrorMessage = l.message;
        nowPlayingState = RequestState.error;
        notifyListeners();
      },
      (r) {
        nowPlayingMovies.addAll(r);
        nowPlayingState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
