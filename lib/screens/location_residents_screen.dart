import 'package:flutter/material.dart';
import '../../models/location.dart';
import '../../models/character.dart';
import '../../services/api_service.dart';
import 'character_detail_screen.dart';

class LocationResidentsScreen extends StatefulWidget {
  final Location location;

  const LocationResidentsScreen({super.key, required this.location});

  @override
  State<LocationResidentsScreen> createState() =>
      _LocationResidentsScreenState();
}

class _LocationResidentsScreenState extends State<LocationResidentsScreen> {
  final ApiService apiService = ApiService();
  List<Character> residents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchResidents();
  }

  Future<void> fetchResidents() async {
    try {
      final futures = widget.location.residents.map((url) {
        final id = int.parse(url.split('/').last);
        return apiService.fetchCharacterById(id);
      });
      final characters = await Future.wait(futures);
      setState(() {
        residents = characters;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Residentes de ${widget.location.name}')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : residents.isEmpty
              ? const Center(child: Text('Nenhum residente encontrado'))
              : ListView.builder(
                itemCount: residents.length,
                itemBuilder: (context, index) {
                  final character = residents[index];
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
