class Location {
  final int id;
  final String name;
  final String type;
  final List<String> residents;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.residents,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      residents: List<String>.from(json['residents']),
    );
  }
}
