part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent {
  const MovieDetailsEvent();
}

class GetMovieDetailsEvent extends MovieDetailsEvent {
  final int id;

  const GetMovieDetailsEvent(this.id);
}

class GetMovieRecommendationEvent extends MovieDetailsEvent {
  final int id;

  const GetMovieRecommendationEvent(this.id);
}
