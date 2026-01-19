import 'package:gastrogo/data/repositories/food_repository.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';

class GetRestaurants {
  GetRestaurants(this.repository);
  final FoodRepository repository;

  Future<List<Restaurant>> call() {
    return repository.getRestaurants();
  }
}
