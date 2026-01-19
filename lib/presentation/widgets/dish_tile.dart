import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastrogo/domain/entities/dish.dart';
import 'package:gastrogo/presentation/providers/providers.dart';

class DishTile extends ConsumerWidget {
  const DishTile({required this.dish, this.onTap, super.key});
  final Dish dish;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favAsync = ref.watch(favoritesProvider);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: dish.imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    placeholder:
                        (c, _) => Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey[100],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                    errorWidget:
                        (c, _, __) => Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey[100],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'R\$ ${dish.price.toStringAsFixed(2)} • '
                        '${dish.vegan ? "Vegano" : "Não vegano"}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                favAsync.when(
                  data: (set) {
                    final isFav = set.contains(dish.id);
                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.redAccent : Colors.grey[400],
                      ),
                      onPressed:
                          () => ref
                              .read(favoritesProvider.notifier)
                              .toggleFavorite(dish.id),
                    );
                  },
                  loading:
                      () => const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  error: (_, __) => const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
