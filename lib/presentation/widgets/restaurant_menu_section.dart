import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';
import 'package:gastrogo/presentation/providers/providers.dart';
import 'package:gastrogo/presentation/widgets/dish_tile.dart';

class RestaurantMenuSection extends ConsumerWidget {
  const RestaurantMenuSection({required this.restaurant, super.key});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dishesAsync = ref.watch(dishesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Título "Cardápio" ---
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          child: Text(
            'Cardápio',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.9),
            ),
          ),
        ),

        // --- Lista de pratos ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: dishesAsync.when(
            loading:
                () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
            error:
                (e, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 48,
                          color: Colors.red[300],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Ops! Não foi possível carregar o cardápio.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => ref.refresh(dishesProvider.future),
                          icon: const Icon(Icons.refresh, size: 18),
                          label: const Text('Tentar Novamente'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            data: (data) {
              final dishes =
                  data.where((d) => d.restaurantId == restaurant.id).toList();

              if (dishes.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('Nenhum prato encontrado.'),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dishes.length,
                itemBuilder: (context, index) {
                  final dish = dishes[index];
                  return DishTile(dish: dish);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
