import 'package:app/BLoC/alojamiento_event.dart';
import 'package:app/data/repositories/alojamiento_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:app/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/BLoC/alojamiento_bloc.dart';

import 'package:app/presentation/screens/home_screen.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final alojamientoRepository = AlojamientoRepository(); 

  runApp( 
    BlocProvider(
      create: (context) {
        return AlojamientosBloc(
          alojamientoRepository: alojamientoRepository
        )..add(AlojamientosLoaded());
      },
      child: MyApp(alojamientoRepository: alojamientoRepository)
    )
  );
}



class MyApp extends StatelessWidget {

  final AlojamientoRepository alojamientoRepository;

  MyApp({Key key, @required this.alojamientoRepository}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Turismo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: BlocProvider<AlojamientosBloc>(
            create: (context) => AlojamientosBloc(alojamientoRepository: alojamientoRepository),
            child: HomeScreen(),
          )
        ),
        routes: routes
      );
  }
}
