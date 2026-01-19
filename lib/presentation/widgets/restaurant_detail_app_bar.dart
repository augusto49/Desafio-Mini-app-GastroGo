import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';
import 'package:gastrogo/presentation/widgets/common/app_network_image.dart';
import 'package:gastrogo/presentation/widgets/common/favorite_button.dart';

class RestaurantDetailAppBar extends ConsumerWidget {
  const RestaurantDetailAppBar({
    required this.restaurant,
    this.heroTagSuffix,
    super.key,
  });

  final Restaurant restaurant;
  final String? heroTagSuffix;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 250,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(6),
        child: CircleAvatar(
          backgroundColor: Colors.black.withValues(alpha: 0.4),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: FavoriteButton(restaurantId: restaurant.id),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'restaurant_${restaurant.id}${heroTagSuffix ?? ''}',
          child: AppNetworkImage(
            imageUrl: restaurant.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
