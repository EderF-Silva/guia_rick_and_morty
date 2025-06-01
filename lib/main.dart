import 'package:flutter/material.dart';
import 'package:guia_rick_and_morty/providers/favorites_provider.dart';
import 'package:guia_rick_and_morty/screens/characters_screen.dart';
import 'package:guia_rick_and_morty/screens/favorites_screen.dart';
import 'package:guia_rick_and_morty/screens/home_screen.dart';
import 'package:guia_rick_and_morty/screens/locations_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: MaterialApp(
        title: 'Guia Rick and Morty',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const HomeScreen(),
        routes: {
          '/characters': (context) => const CharactersScreen(),
          '/favorites': (context) => const FavoritesScreen(),
          '/locations': (context) => const LocationsScreen(),
        },
      ),
    );
  }
}
