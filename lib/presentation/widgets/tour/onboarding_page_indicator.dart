import 'package:flutter/material.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
    required this.activeColor,
  });

  final int pageCount;
  final int currentPage;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final inactiveColor = Theme.of(context).colorScheme.outlineVariant;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage ? activeColor : inactiveColor,
          ),
        ),
      ),
    );
  }
}
