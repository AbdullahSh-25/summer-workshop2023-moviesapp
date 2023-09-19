part of 'movie_details_bloc.dart';

class MovieDetailsState {
  final MovieDetailsModel? movieDetail;
  final RequestState movieDetailsState;
  final String movieDetailsMessage;
  final List<RecommendationModel> recommendation;
  final RequestState recommendationState;
  final String recommendationMessage;

  const MovieDetailsState({
    this.movieDetail,
    this.movieDetailsState = RequestState.initial,
    this.movieDetailsMessage = '',
    this.recommendation = const [],
    this.recommendationState = RequestState.initial,
    this.recommendationMessage = '',
  });

  MovieDetailsState copyWith({
    MovieDetailsModel? movieDetail,
    RequestState? movieDetailsState,
    String? movieDetailsMessage,
    List<RecommendationModel>? recommendation,
    RequestState? recommendationState,
    String? recommendationMessage,
  }) {
    return MovieDetailsState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailsState: movieDetailsState ?? this.movieDetailsState,
      movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
      recommendation: recommendation ?? this.recommendation,
      recommendationState: recommendationState ?? this.recommendationState,
      recommendationMessage: recommendationMessage ?? this.recommendationMessage,
    );
  }
}
