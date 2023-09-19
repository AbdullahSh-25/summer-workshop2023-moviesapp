import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/utils/app_string.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_bloc.dart';
import 'package:movie_app/movies/presentation/screens/lsit_movies_screen.dart';
import 'package:movie_app/movies/presentation/widgets/now_playing_component.dart';
import 'package:movie_app/movies/presentation/widgets/popular_component.dart';
import 'package:movie_app/movies/presentation/widgets/top_rated_component.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MoviesBloc()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              key: const Key('movieScrollView'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NowPlayingComponent(),
                  _SectionHeader(
                    title: AppString.popular,
                    onTap: () {
                      if (state.popularState == RequestState.loaded) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListMoviesScreen(
                              title: AppString.popular,
                              movies: state.popularMovies,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const PopularComponent(),
                  _SectionHeader(
                    title: AppString.topRated,
                    onTap: () {
                      if (state.topRatedState == RequestState.loaded) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListMoviesScreen(
                              title: AppString.popular,
                              movies: state.topRatedMovies,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const TopRatedComponent(),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    AppString.seeMore,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.0,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
