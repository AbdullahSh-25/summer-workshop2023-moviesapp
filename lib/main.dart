import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/app_string.dart';
import 'package:movie_app/movies/presentation/controller/movie_provider/movie_provider.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_bloc.dart';
import 'package:movie_app/movies/presentation/screens/movies_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesBloc(),
      child: ChangeNotifierProvider(
        create: (context){
          return MovieProvider()..getNowPlaying();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppString.appName,
          theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.grey.shade900),
          home: const MoviesScreen(),
        ),
      ),
    );
  }
}
