import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gastrogo/main.dart';

import 'package:gastrogo/data/models/restaurant_model.dart';
import 'package:gastrogo/data/models/dish_model.dart';
import 'package:gastrogo/data/sources/local_json_source.dart';
import 'package:gastrogo/presentation/providers/providers.dart';

class MockLocalJsonSource implements LocalJsonSource {
  @override
  Future<List<RestaurantModel>> loadRestaurants() async => [];

  @override
  Future<List<DishModel>> loadDishes() async => [];
}

void main() {
  testWidgets('GastroGo smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localJsonSourceProvider.overrideWithValue(MockLocalJsonSource()),
        ],
        child: const GastroGoApp(),
      ),
    );

    // Pump frames to allow async providers to settle
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.text('GastroGo'), findsOneWidget);
  });
}
