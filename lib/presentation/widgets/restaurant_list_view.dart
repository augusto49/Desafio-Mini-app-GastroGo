import 'package:flutter/material.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';
import 'package:gastrogo/presentation/pages/restaurant_detail_page.dart';
import 'package:gastrogo/presentation/widgets/restaurant_card.dart';

class RestaurantListView extends StatelessWidget {
  const RestaurantListView({
    required this.restaurants,
    required this.hasMore,
    required this.onLoadMore,
    required this.onRefresh,
    super.key,
  });

  final List<Restaurant> restaurants;
  final bool hasMore;
  final VoidCallback onLoadMore;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return const Center(child: Text('Nenhum restaurante encontrado.'));
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: restaurants.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == restaurants.length) {
            onLoadMore();
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }
          final restaurant = restaurants[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: RestaurantCard(
              restaurant: restaurant,
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder:
                          (_) => RestaurantDetailPage(restaurant: restaurant),
                    ),
                  ),
            ),
          );
        },
      ),
    );
  }
}
