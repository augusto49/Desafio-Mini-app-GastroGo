import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastrogo/domain/entities/restaurant.dart';
import 'package:gastrogo/presentation/providers/providers.dart';

class PaginatedRestaurantsNotifier extends AsyncNotifier<List<Restaurant>> {
  static const int _limit = 8;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isFetching = false;

  @override
  FutureOr<List<Restaurant>> build() async {
    _currentPage = 1;
    _hasMore = true;
    return _fetch(page: 1);
  }

  bool get hasMore => _hasMore;

  Future<List<Restaurant>> _fetch({required int page}) async {
    final useCase = ref.read(getPaginatedRestaurantsProvider);
    final data = await useCase(page: page, limit: _limit);
    if (data.length < _limit) {
      _hasMore = false;
    }
    return data;
  }

  Future<void> refresh() async {
    if (_isFetching) return;
    state = const AsyncValue.loading();
    _currentPage = 1;
    _hasMore = true;
    try {
      final data = await _fetch(page: 1);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !_hasMore || _isFetching) return;

    _isFetching = true;
    try {
      final currentData = state.value ?? [];
      final nextPage = _currentPage + 1;

      final newData = await _fetch(page: nextPage);

      _currentPage = nextPage;
      state = AsyncValue.data([...currentData, ...newData]);
    } catch (e, st) {
      // Mantém os dados anteriores mas sinaliza erro, permitindo
      // que a UI mostre uma snackbar ou botão de retry no rodapé
      state = AsyncValue<List<Restaurant>>.error(e, st).copyWithPrevious(state);
    } finally {
      _isFetching = false;
    }
  }
}

final paginatedRestaurantsProvider =
    AsyncNotifierProvider<PaginatedRestaurantsNotifier, List<Restaurant>>(
      PaginatedRestaurantsNotifier.new,
    );
