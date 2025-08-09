import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/bloc/client_bloc.dart';
import 'src/data/in_memory_repository.dart';
import 'src/ui/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => InMemoryRepository(),
      child: BlocProvider(
        create: (context) =>
            ClientBloc(context.read<InMemoryRepository>())..add(LoadClientsEvent()),
        child: MaterialApp(
          title: 'Coach Dashboard',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C7A6F)),
            useMaterial3: true,
            fontFamily: 'Roboto',
          ),
          home: const DashboardScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
