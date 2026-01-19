import 'package:flutter/material.dart';

class RestaurantSearchBar extends StatelessWidget {
  const RestaurantSearchBar({
    required this.query,
    required this.onQueryChanged,
    required this.onFilterToggle,
    required this.isFiltersVisible,
    super.key,
  });

  final String query;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onFilterToggle;
  final bool isFiltersVisible;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: TextField(
                onChanged: onQueryChanged,
                decoration: InputDecoration(
                  hintText: 'Buscar restaurantes...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(Icons.search, color: color),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: color.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onFilterToggle,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isFiltersVisible ? color : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isFiltersVisible ? color : Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isFiltersVisible ? color : Colors.black).withValues(
                      alpha: 0.1,
                    ),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                Icons.tune_rounded,
                color: isFiltersVisible ? Colors.white : color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
