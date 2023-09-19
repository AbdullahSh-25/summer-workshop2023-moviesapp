import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_bloc.dart';
import 'package:movie_app/movies/presentation/widgets/error_message_widget.dart';
import 'package:movie_app/movies/presentation/widgets/loading_widget.dart';
import 'package:movie_app/movies/presentation/widgets/movie_card.dart';

class TopRatedComponent extends StatelessWidget {
  const TopRatedComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (previous, current) => previous.topRatedState != current.topRatedState,
      builder: (context, state) {
        return switch (state.topRatedState) {
          RequestState.initial => const SizedBox.shrink(),
          RequestState.loading => const LoadingWidget(),
          RequestState.error => ErrorMessageWidget(message: state.nowPlayingMessage),
          RequestState.loaded => FadeIn(
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: 170.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: state.topRatedMovies.length,
                  itemBuilder: (context, index) {
                    final movieItem = state.topRatedMovies[index];
                    return MovieCard(movieItem: movieItem);
                  },
                ),
              ),
            ),
        };
      },
    );
  }
}
