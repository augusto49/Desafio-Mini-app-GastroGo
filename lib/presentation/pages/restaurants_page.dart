import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastrogo/presentation/providers/paginated_restaurants_provider.dart';
import 'package:gastrogo/presentation/widgets/restaurant_card_skeleton.dart';
import 'package:gastrogo/presentation/widgets/restaurant_error_view.dart';
import 'package:gastrogo/presentation/widgets/restaurant_filters_panel.dart';
import 'package:gastrogo/presentation/widgets/restaurant_list_view.dart';
import 'package:gastrogo/presentation/widgets/restaurant_search_bar.dart';

class RestaurantsPage extends ConsumerStatefulWidget {
  const RestaurantsPage({super.key});

  @override
  ConsumerState<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends ConsumerState<RestaurantsPage> {
  String query = '';
  String category = 'All';
  String sortBy = 'rating';
  bool _isFiltersVisible = false;

  @override
  Widget build(BuildContext context) {
    final asyncRestaurants = ref.watch(paginatedRestaurantsProvider);
    final notifier = ref.read(paginatedRestaurantsProvider.notifier);

    // Escuta erros de paginação
    // (quando já tem dados mas falhou ao carregar mais)
    ref.listen(paginatedRestaurantsProvider, (previous, next) {
      if (!next.isLoading && next.hasError && next.hasValue) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar mais itens: ${next.error}'),
            action: SnackBarAction(
              label: 'Tentar recarregar',
              onPressed: notifier.loadMore,
            ),
          ),
        );
      }
    });

    return Column(
      children: [
        RestaurantSearchBar(
          query: query,
          onQueryChanged: (v) => setState(() => query = v),
          onFilterToggle:
              () => setState(() => _isFiltersVisible = !_isFiltersVisible),
          isFiltersVisible: _isFiltersVisible,
        ),
        RestaurantFiltersPanel(
          isVisible: _isFiltersVisible,
          selectedCategory: category,
          onCategoryChanged: (v) => setState(() => category = v),
          selectedSort: sortBy,
          onSortChanged: (v) => setState(() => sortBy = v),
        ),
        Expanded(
          child: asyncRestaurants.when(
            skipError: true,
            loading:
                () => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: 4,
                  itemBuilder:
                      (context, index) => const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: RestaurantCardSkeleton(),
                      ),
                ),
            error:
                (e, _) => RestaurantErrorView(
                  message: 'Ops! Não foi possível carregar os restaurantes.',
                  onRetry: notifier.refresh,
                ),
            data: (restaurants) {
              // --- Aplica filtros ---
              var filtered =
                  restaurants
                      .where(
                        (r) =>
                            r.name.toLowerCase().contains(query.toLowerCase()),
                      )
                      .toList();

              if (category != 'All') {
                filtered =
                    filtered.where((r) => r.category == category).toList();
              }

              // --- Aplica ordenação ---
              if (sortBy == 'rating') {
                filtered.sort((a, b) => b.rating.compareTo(a.rating));
              } else {
                filtered.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
              }

              return RestaurantListView(
                restaurants: filtered,
                hasMore: notifier.hasMore,
                onLoadMore: notifier.loadMore,
                onRefresh: notifier.refresh,
              );
            },
          ),
        ),
      ],
    );
  }
}
