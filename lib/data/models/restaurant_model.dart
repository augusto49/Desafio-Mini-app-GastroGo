import 'package:gastrogo/domain/entities/restaurant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

@JsonSerializable()
class RestaurantModel {

  RestaurantModel({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.distance_km,
    required this.image_url,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
  final String id;
  final String name;
  final String category;
  final double rating;
  final double distance_km;
  final String image_url;
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  Restaurant toEntity() {
    return Restaurant(
      id: id,
      name: name,
      category: category,
      rating: rating,
      distanceKm: distance_km,
      imageUrl: image_url,
    );
  }
}
