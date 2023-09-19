import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/presentation/controller/movie_provider/movie_provider.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_bloc.dart';
import 'package:movie_app/movies/presentation/screens/movie_detail_screen.dart';
import 'package:movie_app/movies/presentation/widgets/error_message_widget.dart';
import 'package:movie_app/movies/presentation/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../data/models/movie_model.dart';

class NowPlayingComponent extends StatelessWidget {
  const NowPlayingComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context,provider,_) {
        switch(provider.nowPlayingState){
          case RequestState.initial:
            return const SizedBox();
          case RequestState.loading:
            return const LoadingWidget();
          case RequestState.loaded:
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: CarouselSlider(
              options: CarouselOptions(height: 400.0, viewportFraction: 1.0),
              items: provider.nowPlayingMovies.map((movieItem) {
                return GestureDetector(
                  key: const Key('openMovieMinimalDetail'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MovieDetailScreen(
                              id: movieItem.id,
                            ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              // fromLTRB
                              Colors.transparent,
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [0, 0.3, 0.5, 1],
                          ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: CachedNetworkImage(
                          height: 560.0,
                          imageUrl: ApiConstants.imageUrl(movieItem.backdropPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.redAccent,
                                    size: 16.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    'Now Playing'.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                movieItem.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
          case RequestState.error:
            return ErrorMessageWidget(message: provider.nowPlayingErrorMessage);
        }

      },
    );
  }
}