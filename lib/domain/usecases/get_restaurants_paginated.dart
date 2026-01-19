import 'package:gastrogo/data/repositories/food_repository.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';

class GetPaginatedRestaurants {
  GetPaginatedRestaurants(this.repository);

  final FoodRepository repository;

  Future<List<Restaurant>> call({required int page, int limit = 8}) {
    return repository.getRestaurantsPaginated(page: page, limit: limit);
  }
}
