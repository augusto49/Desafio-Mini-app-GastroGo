import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastrogo/presentation/pages/restaurant_detail_page.dart';
import 'package:gastrogo/presentation/providers/providers.dart';
import 'package:gastrogo/presentation/widgets/dish_tile.dart';
import 'package:gastrogo/presentation/widgets/restaurant_card.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favsAsync = ref.watch(favoritesProvider);
    final restaurantsAsync = ref.watch(restaurantsProvider);
    final dishesAsync = ref.watch(dishesProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: favsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erro: $e')),
        data: (favs) {
          if (favs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum favorito ainda',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Restaurantes Favoritos ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Restaurantes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary.withOpacity(0.9),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                restaurantsAsync.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const SizedBox(),
                  data: (restaurants) {
                    final favRestaurants =
                        restaurants.where((r) => favs.contains(r.id)).toList();

                    if (favRestaurants.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Nenhum restaurante favoritado.',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: favRestaurants.length,
                      itemBuilder: (context, index) {
                        final r = favRestaurants[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: RestaurantCard(
                            restaurant: r,
                            heroTagSuffix: 'fav',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => RestaurantDetailPage(
                                        restaurant: r,
                                        heroTagSuffix: 'fav',
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 32),

                // --- Pratos Favoritos ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Pratos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary.withOpacity(0.9),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                dishesAsync.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const SizedBox(),
                  data: (dishes) {
                    final favDishes =
                        dishes.where((d) => favs.contains(d.id)).toList();

                    if (favDishes.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Nenhum prato favoritado.',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      );
                    }

                    return restaurantsAsync.when(
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error:
                          (_, __) => Column(
                            children:
                                favDishes
                                    .map((d) => DishTile(dish: d))
                                    .toList(),
                          ),
                      data: (restaurants) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children:
                                favDishes.map((d) {
                                  return DishTile(
                                    dish: d,
                                    onTap: () {
                                      try {
                                        final rest = restaurants.firstWhere(
                                          (r) => r.id == d.restaurantId,
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => RestaurantDetailPage(
                                                  restaurant: rest,
                                                ),
                                          ),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Restaurante do prato não encontrado.',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }).toList(),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
