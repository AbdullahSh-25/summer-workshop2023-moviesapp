part of 'movies_bloc.dart';

class MoviesState {
  final List<MovieModel> nowPlayingMovies;
  final RequestState nowPlayingState;
  final String nowPlayingMessage;
  final List<MovieModel> popularMovies;
  final RequestState popularState;
  final String popularMessage;
  final List<MovieModel> topRatedMovies;
  final RequestState topRatedState;
  final String topRatedMessage;

  const MoviesState({
    this.nowPlayingMovies = const [],
    this.nowPlayingState = RequestState.initial,
    this.nowPlayingMessage = '',
    this.popularMovies = const [],
    this.popularState = RequestState.initial,
    this.popularMessage = '',
    this.topRatedMovies = const [],
    this.topRatedState = RequestState.initial,
    this.topRatedMessage = '',
  });

  MoviesState copyWith({
    List<MovieModel>? nowPlayingMovies,
    RequestState? nowPlayingState,
    String? nowPlayingMessage,
    List<MovieModel>? popularMovies,
    RequestState? popularState,
    String? popularMessage,
    List<MovieModel>? topRatedMovies,
    RequestState? topRatedState,
    String? topRatedMessage,
  }) {
    return MoviesState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
      popularMovies: popularMovies ?? this.popularMovies,
      popularState: popularState ?? this.popularState,
      popularMessage: popularMessage ?? this.popularMessage,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedState: topRatedState ?? this.topRatedState,
      topRatedMessage: topRatedMessage ?? this.topRatedMessage,
    );
  }
}
