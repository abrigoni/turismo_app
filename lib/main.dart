import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/BLoC/simple_bloc_delegate.dart';
import 'package:app/routes.dart';
import 'package:app/BLoC/alojamiento_event.dart';
import 'package:app/BLoC/alojamiento_bloc.dart';
import 'package:app/data/repositories/alojamiento_repository.dart';
import 'package:app/presentation/screens/home_screen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlojamientosBloc>(
      create: (context) => AlojamientosBloc( alojamientoRepository: AlojamientoRepository())..add( AlojamientosLoaded() ) ,
      child: MaterialApp(
        title: 'Turismo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.ROUTENAME,
        routes: routes),
    );
  }
}
