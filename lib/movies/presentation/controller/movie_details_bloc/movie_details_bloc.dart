import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/data/models/movie_details_model.dart';
import 'package:movie_app/movies/data/models/recommendation_model.dart';
import 'package:movie_app/movies/data/repository/movies_repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieRecommendationEvent>(_getRecommendation);
  }

  FutureOr<void> _getMovieDetails(GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(movieDetailsState: RequestState.loading));

    final result = await MoviesRepository.getMovieDetails(event.id);

    result.fold(
      (l) => emit(state.copyWith(
        movieDetailsState: RequestState.error,
        movieDetailsMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          movieDetailsState: RequestState.loaded,
          movieDetail: r,
        ),
      ),
    );
  }

  FutureOr<void> _getRecommendation(GetMovieRecommendationEvent event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(recommendationState: RequestState.loading));

    final result = await MoviesRepository.getRecommendation(event.id);

    result.fold(
      (l) => emit(state.copyWith(
        recommendationState: RequestState.error,
        recommendationMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          recommendationState: RequestState.loaded,
          recommendation: r,
        ),
      ),
    );
  }
}
