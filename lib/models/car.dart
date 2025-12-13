class Car {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final int seats;
  final double pricePerDay;
  final bool available;
  final String description;

  Car({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.seats,
    required this.pricePerDay,
    required this.available,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'category': category,
      'seats': seats,
      'pricePerDay': pricePerDay,
      'available': available,
      'description': description,
    };
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      seats: json['seats'],
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      available: json['available'],
      description: json['description'],
    );
  }
}
