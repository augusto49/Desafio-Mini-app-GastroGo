import 'package:gastrogo/core/exceptions/exceptions.dart';
import 'package:gastrogo/data/sources/fake_remote_source.dart';
import 'package:gastrogo/domain/entities/dish.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';

class FoodRepository {
  FoodRepository({required this.source});
  final FakeRemoteSource source;

  Future<List<Restaurant>> getRestaurants() async {
    try {
      final models = await source.fetchRestaurants();
      return models.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<Dish>> getDishes() async {
    try {
      final models = await source.fetchDishes();
      return models.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<Dish>> getDishesByRestaurant(String restaurantId) async {
    try {
      final dishes = await getDishes();
      return dishes.where((d) => d.restaurantId == restaurantId).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// Scroll infinito (Safe Pagination)
  Future<List<Restaurant>> getRestaurantsPaginated({
    required int page,
    int limit = 8,
  }) async {
    try {
      final all = await getRestaurants();
      if (all.isEmpty) return [];

      final start = (page - 1) * limit;
      if (start >= all.length) return [];

      final end = start + limit > all.length ? all.length : start + limit;
      return all.sublist(start, end);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
