import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/controller/Movie_Cubit/Movie_Cubit.dart';
import 'package:movies_app/controller/Movies_Repo.dart';

import '../../controller/Page_Cubit/page_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var pageCubit = context.read<PageCubit>();

    return BlocBuilder<PageCubit, PageState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => MovieCubit(context.read<MoviesRepo>())..fetchSample3DMovies()..fetchMovies(),
          child: Scaffold(

              backgroundColor: Color.fromRGBO(44, 43, 43, 1),

              body: pageCubit.pages[pageCubit.currentIndex],

              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Color.fromRGBO(44, 43, 43, 1),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.movie),
                    label: 'Movies',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.tv),
                    label: 'TV Shows',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                ],
                currentIndex: 0,
                selectedItemColor: Colors.amber[800],
                onTap: (index) {
                  pageCubit.changeIndex(index);
                },
              )

          ),
        );
      },
    );
  }
}
