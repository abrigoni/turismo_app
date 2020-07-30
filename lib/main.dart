import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/BLoC/bloc.dart';
import 'package:app/routes.dart';
import 'package:app/data/repositories/gastronomico_repository.dart';
import 'package:app/data/repositories/alojamiento_repository.dart';
import 'package:app/presentation/screens/home_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build(
    storageDirectory: await getApplicationDocumentsDirectory()
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GastronomicosBloc>(
          create: (context) => GastronomicosBloc( gastronomicoRepository: GastronomicoRepository())..add( GastronomicosFetch() )
        ),
        BlocProvider<AlojamientosBloc>( 
          create: (context) => AlojamientosBloc( alojamientoRepository: AlojamientoRepository())..add( AlojamientosFetch() ) 
        ),
        BlocProvider<FavoritosBloc>(
          create: (context) => FavoritosBloc()..add(FavoritosFetch())
        )
      ],
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
