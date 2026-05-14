import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../shared/responsive.dart';
import '../../../../shared/widgets/fade_in.dart';
import '../../../../shared/widgets/hover_lift.dart';

class HighlightsSection extends StatelessWidget {
  const HighlightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final mobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.porcelain,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 84),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeading(
                eyebrow: 'Resort highlights',
                title: 'A stay composed around calm, craft, and quiet luxury.',
              ),
              const SizedBox(height: 34),
              GridView.count(
                crossAxisCount: mobile ? 1 : 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 22,
                mainAxisSpacing: 22,
                childAspectRatio: mobile ? 1.7 : 1.05,
                children: const [
                  _HighlightCard(
                    icon: Icons.pool_outlined,
                    title: 'Infinity pool',
                    body: 'Temperature-controlled water with open views.',
                  ),
                  _HighlightCard(
                    icon: Icons.restaurant_outlined,
                    title: 'Coastal dining',
                    body: 'Seasonal menus, private tables, and gold-hour service.',
                  ),
                  _HighlightCard(
                    icon: Icons.spa_outlined,
                    title: 'Garden spa',
                    body: 'Slow rituals, aromatherapy, and forest-facing suites.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: HoverLift(
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.softGrey),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepForest.withValues(alpha: 0.08),
                blurRadius: 28,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(icon, color: AppColors.gold, size: 34),
              const SizedBox(height: 20),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                body,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.charcoal.withValues(alpha: 0.68),
                      height: 1.5,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.eyebrow, required this.title});

  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.gold,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.8,
                ),
          ),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}
