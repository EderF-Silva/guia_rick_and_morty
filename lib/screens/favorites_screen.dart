import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/api_service.dart';
import '../../models/character.dart';
import '../../providers/favorites_provider.dart';
import 'character_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ApiService apiService = ApiService();
  List<Character> favoriteCharacters = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favoritesProvider = Provider.of<FavoritesProvider>(
      context,
      listen: false,
    );
    final ids = favoritesProvider.favorites;
    try {
      final futures = ids.map((id) => apiService.fetchCharacterById(id));
      final characters = await Future.wait(futures);
      setState(() {
        favoriteCharacters = characters;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : favoriteCharacters.isEmpty
              ? const Center(child: Text('Nenhum favorito salvo'))
              : ListView.builder(
                itemCount: favoriteCharacters.length,
                itemBuilder: (context, index) {
                  final character = favoriteCharacters[index];
                  return ListTile(
                    leading: Image.network(character.image),
                    title: Text(character.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => CharacterDetailScreen(
                                characterId: character.id,
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
