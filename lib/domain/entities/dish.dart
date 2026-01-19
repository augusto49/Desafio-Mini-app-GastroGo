class Dish {

  const Dish({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    required this.vegan,
    required this.imageUrl,
  });
  final String id;
  final String restaurantId;
  final String name;
  final double price;
  final bool vegan;
  final String imageUrl;
}
