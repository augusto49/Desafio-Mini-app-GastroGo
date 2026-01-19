import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gastrogo/presentation/pages/restaurants_page.dart';

import 'package:gastrogo/presentation/widgets/restaurant_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';
import 'package:gastrogo/presentation/providers/paginated_restaurants_provider.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel channel = MethodChannel(
    'plugins.flutter.io/path_provider',
  );

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '.';
        });
  });

  testWidgets('renders restaurant list and search bar', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the whole paginated provider for simplicity in this test
          paginatedRestaurantsProvider.overrideWith(() => MockNotifier()),
        ],
        child: const MaterialApp(home: Scaffold(body: RestaurantsPage())),
      ),
    );

    expect(find.byType(TextField), findsOneWidget); // Search bar
    await tester.pump(); // Start building
    await tester.pump(const Duration(milliseconds: 100)); // Wait for build

    expect(find.byType(RestaurantCard), findsOneWidget);
  });
}

class MockNotifier extends PaginatedRestaurantsNotifier {
  @override
  Future<List<Restaurant>> build() async {
    return [
      const Restaurant(
        id: 'r1',
        name: 'Test Rest',
        category: 'Brasileira',
        rating: 5.0,
        distanceKm: 1.0,
        imageUrl: '',
      ),
    ];
  }

  @override
  bool get hasMore => false;
}
