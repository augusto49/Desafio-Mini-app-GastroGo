import 'package:flutter/material.dart';
import 'package:gastrogo/core/responsive_utils.dart';
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

    final columns = ResponsiveUtils.getGridColumns(context);
    final itemCount = restaurants.length + (hasMore ? 1 : 0);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Para phones (1 coluna), usa ListView
          if (columns == 1) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: itemCount,
              itemBuilder: (context, index) => _buildItem(context, index),
            );
          }

          // Para tablets/desktop, usa GridView
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: _getAspectRatio(constraints.maxWidth, columns),
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) => _buildGridItem(context, index),
          );
        },
      ),
    );
  }

  double _getAspectRatio(double width, int columns) {
    // Calcular aspect ratio baseado no tamanho do card
    // Card tem imagem de 180px + ~80px de conteúdo = ~260px altura
    final cardWidth = (width - 32 - (16 * (columns - 1))) / columns;
    return cardWidth / 280;
  }

  Widget _buildItem(BuildContext context, int index) {
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
        onTap: () => _navigateToDetail(context, restaurant),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    if (index == restaurants.length) {
      onLoadMore();
      return const Center(child: CircularProgressIndicator());
    }

    final restaurant = restaurants[index];
    return RestaurantCard(
      restaurant: restaurant,
      onTap: () => _navigateToDetail(context, restaurant),
    );
  }

  void _navigateToDetail(BuildContext context, Restaurant restaurant) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RestaurantDetailPage(restaurant: restaurant),
      ),
    );
  }
}
