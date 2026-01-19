import 'package:gastrogo/data/repositories/food_repository.dart';
import 'package:gastrogo/domain/entities/dish.dart';

class GetDishes {
  GetDishes(this.repository);

  final FoodRepository repository;

  Future<List<Dish>> call() {
    return repository.getDishes();
  }
}
