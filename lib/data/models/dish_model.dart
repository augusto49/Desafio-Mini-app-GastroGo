import 'package:gastrogo/domain/entities/dish.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dish_model.g.dart';

@JsonSerializable()
class DishModel {

  DishModel({
    required this.id,
    required this.restaurant_id,
    required this.name,
    required this.price,
    required this.vegan,
    required this.image_url,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) =>
      _$DishModelFromJson(json);
  final String id;
  final String restaurant_id;
  final String name;
  final double price;
  final bool vegan;
  final String image_url;
  Map<String, dynamic> toJson() => _$DishModelToJson(this);

  Dish toEntity() {
    return Dish(
      id: id,
      restaurantId: restaurant_id,
      name: name,
      price: price,
      vegan: vegan,
      imageUrl: image_url,
    );
  }
}
