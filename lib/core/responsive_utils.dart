import 'package:flutter/material.dart';

/// Breakpoints para responsividade
class Breakpoints {
  static const double phone = 600;
  static const double tablet = 900;
}

/// Utilitários para layouts responsivos
class ResponsiveUtils {
  /// Retorna true se a tela é de smartphone (< 600)
  static bool isPhone(BuildContext context) {
    return MediaQuery.sizeOf(context).width < Breakpoints.phone;
  }

  /// Retorna true se a tela é de tablet (600-900)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= Breakpoints.phone && width < Breakpoints.tablet;
  }

  /// Retorna true se a tela é de desktop (> 900)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= Breakpoints.tablet;
  }

  /// Retorna o número de colunas para GridView baseado no tamanho da tela
  static int getGridColumns(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoints.tablet) return 3;
    if (width >= Breakpoints.phone) return 2;
    return 1;
  }

  /// Retorna a largura máxima recomendada para conteúdo
  static double getMaxContentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoints.tablet) return 1200;
    if (width >= Breakpoints.phone) return 800;
    return double.infinity;
  }
}

/// Widget que centraliza o conteúdo com largura máxima
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    required this.child,
    this.maxWidth,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    super.key,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? ResponsiveUtils.getMaxContentWidth(context),
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Widget de grid responsivo que adapta colunas ao tamanho da tela
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
    this.childAspectRatio = 1.0,
    this.padding = const EdgeInsets.all(16),
    this.shrinkWrap = false,
    this.physics,
    super.key,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final EdgeInsets padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.getGridColumns(context);

    // Se for apenas 1 coluna (phone), usa ListView para melhor performance
    if (columns == 1) {
      return ListView.builder(
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: itemCount,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: mainAxisSpacing),
            child: itemBuilder(ctx, index),
          );
        },
      );
    }

    return GridView.builder(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
