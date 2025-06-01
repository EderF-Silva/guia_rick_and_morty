import 'package:flutter/material.dart';
import '../../models/location.dart';
import '../../services/api_service.dart';
import 'location_residents_screen.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final ApiService apiService = ApiService();
  List<Location> locations = [];
  int page = 1;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchLocations();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        page++;
        fetchLocations();
      }
    });
  }

  Future<void> fetchLocations() async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedLocations = await apiService.fetchLocations(page);
      setState(() {
        locations.addAll(fetchedLocations);
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locais')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: locations.length + 1,
        itemBuilder: (context, index) {
          if (index < locations.length) {
            final location = locations[index];
            return ListTile(
              title: Text(location.name),
              subtitle: Text(location.type),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LocationResidentsScreen(location: location),
                  ),
                );
              },
            );
          } else {
            return Center(
              child:
                  isLoading
                      ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      )
                      : const SizedBox.shrink(),
            );
          }
        },
      ),
    );
  }
}
