import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastrogo/presentation/providers/providers.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    required this.restaurantId,
    this.size = 24.0,
    this.activeColor = Colors.redAccent,
    this.inactiveColor = Colors.white,
    this.isCircle = true,
    this.backgroundColor = Colors.black45,
    this.boxShadow,
    this.loadingColor = Colors.white,
    super.key,
  });

  final String restaurantId;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final bool isCircle;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final Color loadingColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favAsync = ref.watch(favoritesProvider);

    return favAsync.when(
      data: (set) {
        final isFav = set.contains(restaurantId);
        return _buildContainer(
          context: context,
          child: IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? activeColor : inactiveColor,
              size: size,
            ),
            onPressed:
                () => ref
                    .read(favoritesProvider.notifier)
                    .toggleFavorite(restaurantId),
          ),
        );
      },
      loading:
          () => _buildContainer(
            context: context,
            child: SizedBox(
              width: size,
              height: size,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: loadingColor,
                ),
              ),
            ),
          ),
      error:
          (_, __) => _buildContainer(
            context: context,
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: inactiveColor,
                size: size,
              ),
              onPressed:
                  () => ref
                      .read(favoritesProvider.notifier)
                      .toggleFavorite(restaurantId),
            ),
          ),
    );
  }

  Widget _buildContainer({
    required BuildContext context,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(8),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
