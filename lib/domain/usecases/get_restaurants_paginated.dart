import 'package:gastrogo/data/repositories/food_repository.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';

class GetPaginatedRestaurants {
  final FoodRepository repository;
  GetPaginatedRestaurants(this.repository);

  Future<List<Restaurant>> call({required int page, int limit = 8}) {
    return repository.getRestaurantsPaginated(page: page, limit: limit);
  }
}
