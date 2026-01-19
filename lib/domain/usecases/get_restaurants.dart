import 'package:gastrogo/data/repositories/food_repository.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';

class GetRestaurants {
  final FoodRepository repository;
  GetRestaurants(this.repository);

  Future<List<Restaurant>> call() {
    return repository.getRestaurants();
  }
}
