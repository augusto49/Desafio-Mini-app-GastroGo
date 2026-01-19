import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';
import 'package:gastrogo/presentation/providers/providers.dart';
import 'package:gastrogo/presentation/widgets/restaurant_detail_app_bar.dart';
import 'package:gastrogo/presentation/widgets/restaurant_info_card.dart';
import 'package:gastrogo/presentation/widgets/restaurant_menu_section.dart';

class RestaurantDetailPage extends ConsumerWidget {
  const RestaurantDetailPage({
    required this.restaurant,
    this.heroTagSuffix,
    super.key,
  });
  final Restaurant restaurant;
  final String? heroTagSuffix;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: () async {
          return ref.refresh(dishesProvider.future);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // --- AppBar ---
            RestaurantDetailAppBar(
              restaurant: restaurant,
              heroTagSuffix: heroTagSuffix,
            ),

            // --- Corpo Principal ---
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Info Card ---
                  RestaurantInfoCard(restaurant: restaurant),

                  // --- Menu ---
                  RestaurantMenuSection(restaurant: restaurant),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
