import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';
import 'package:gastrogo/presentation/pages/restaurant_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gastrogo/presentation/providers/providers.dart';

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

  testWidgets('renders restaurant detail page', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    // Use empty URL to avoid network calls hopefully
    final restaurant = const Restaurant(
      id: 'r1',
      name: 'Sabor Mineiro',
      category: 'Brasileira',
      rating: 4.5,
      distanceKm: 2.3,
      imageUrl: 'https://example.com/image.jpg',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dishesProvider.overrideWith((ref) async {
            return const [];
          }),
        ],
        child: MaterialApp(home: RestaurantDetailPage(restaurant: restaurant)),
      ),
    );

    await tester.pump();

    expect(find.text('Sabor Mineiro'), findsOneWidget);
  });
}
