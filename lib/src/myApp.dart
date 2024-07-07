import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisteps/src/di.dart';

import 'presentation/detail/bloc/bloc.dart';
import 'presentation/home/UI/home_view.dart';
import 'presentation/home/bloc/bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(
          create: (context) => locator<UsersBloc>(),
        ),
        BlocProvider<UserDetailBloc>(
          create: (context) => locator<UserDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'TISTEPS TASK',
        theme: ThemeData(
          fontFamily: 'SF-Pro',
          scaffoldBackgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'SF-Pro'),
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.dark,
        home: const HomeView(),
      ),
    );
  }
}
