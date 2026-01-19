import 'package:flutter/material.dart';

class RestaurantFiltersPanel extends StatelessWidget {
  const RestaurantFiltersPanel({
    required this.isVisible,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.selectedSort,
    required this.onSortChanged,
    super.key,
  });

  final bool isVisible;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  final String selectedSort;
  final ValueChanged<String> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child:
          isVisible
              ? Container(
                width: double.infinity,
                color: Colors.grey[50],
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categoria
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Categorias',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children:
                            [
                              'All',
                              'Japonesa',
                              'Italiana',
                              'Brasileira',
                              'Saudável',
                              'Mexicana',
                              'Francesa',
                              'Árabe',
                            ].map((c) {
                              final isSelected = selectedCategory == c;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: FilterChip(
                                  label: Text(c),
                                  selected: isSelected,
                                  onSelected: (bool selected) {
                                    onCategoryChanged(c);
                                  },
                                  selectedColor: color.withValues(alpha: 0.2),
                                  checkmarkColor: color,
                                  labelStyle: TextStyle(
                                    color: isSelected ? color : Colors.black87,
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color:
                                          isSelected
                                              ? color
                                              : Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Ordenação
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Ordenar por',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildSortOption(
                              'Rating',
                              'rating',
                              Icons.star_rounded,
                              color,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSortOption(
                              'Distância',
                              'distance',
                              Icons.location_on_outlined,
                              color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  Widget _buildSortOption(
    String label,
    String value,
    IconData icon,
    Color activeColor,
  ) {
    final isSelected = selectedSort == value;
    return GestureDetector(
      onTap: () => onSortChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? activeColor : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? activeColor : Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? activeColor : Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
