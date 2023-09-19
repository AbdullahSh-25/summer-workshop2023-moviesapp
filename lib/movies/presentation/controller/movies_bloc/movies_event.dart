part of 'movies_bloc.dart';

abstract class MoviesEvent {
  const MoviesEvent();
}

class GetNowPlayingMoviesEvent extends MoviesEvent {}

class GetPopularMoviesEvent extends MoviesEvent {}

class GetTopRatedMoviesEvent extends MoviesEvent {}
