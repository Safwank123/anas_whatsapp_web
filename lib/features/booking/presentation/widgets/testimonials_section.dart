import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../shared/responsive.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final mobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.champagne,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 84),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Guest stories',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 28),
              if (mobile)
                const Column(
                  children: [
                    _TestimonialCard(
                      quote:
                          'Every detail felt considered, from the arrival tea to the private dinner by the pool.',
                      guest: 'Meera Shah',
                    ),
                    SizedBox(height: 20),
                    _TestimonialCard(
                      quote:
                          'The booking was effortless, the villa was serene, and the team made the stay feel personal.',
                      guest: 'Arjun Nair',
                    ),
                  ],
                )
              else
                const Row(
                  children: [
                    Expanded(
                      child: _TestimonialCard(
                        quote:
                            'Every detail felt considered, from the arrival tea to the private dinner by the pool.',
                        guest: 'Meera Shah',
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _TestimonialCard(
                        quote:
                            'The booking was effortless, the villa was serene, and the team made the stay feel personal.',
                        guest: 'Arjun Nair',
                      ),
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

class _TestimonialCard extends StatelessWidget {
  const _TestimonialCard({required this.quote, required this.guest});

  final String quote;
  final String guest;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote_rounded, color: AppColors.gold),
          const SizedBox(height: 16),
          Text(
            quote,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.charcoal,
                  height: 1.55,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            guest,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.forest,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
