class Restaurant {

  const Restaurant({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.distanceKm,
    required this.imageUrl,
  });
  final String id;
  final String name;
  final String category;
  final double rating;
  final double distanceKm;
  final String imageUrl;
}
