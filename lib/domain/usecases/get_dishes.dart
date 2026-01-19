import 'package:gastrogo/data/repositories/food_repository.dart';
import 'package:gastrogo/domain/entities/dish.dart';

class GetDishes {
  final FoodRepository repository;
  GetDishes(this.repository);

  Future<List<Dish>> call() {
    return repository.getDishes();
  }
}
